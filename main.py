from flask import Flask, url_for, render_template, request
from sqlalchemy import create_engine
from forms import bookSearchform
from rapidfuzz import process, fuzz

import pandas as pd

app = Flask(__name__)


def connection():
    Server = "(localdb)\MSSQLLocalDB"
    Database = "Ksiegarnia"
    Driver = "ODBC Driver 17 for SQL Server"
    Database_Con = f"mssql://@{Server}/{Database}?driver={Driver}"

    engine = create_engine(Database_Con)
    con = engine.connect()

    df = pd.read_sql_query("SELECT tytul AS 'Tytuł Książki', cena AS 'Cena [zł]', imie AS 'Imię autora', nazwisko AS 'Nazwisko autora', \
     nazwa AS 'Wydawnictwo' FROM [dbo].[Ksiazka] \
    JOIN [dbo].[Autor] ON Ksiazka.Autor_id = Autor.id_autor \
    JOIN [dbo].[Wydawca] ON Ksiazka.Wydawca_id = Wydawca.id_wydawca", con)
    # print(df.columns)
    # print(df)
    return df


@app.route('/', methods=("POST", "GET"))
def index():
    df = connection()
    search = bookSearchform(request.form)
    if request.method == 'POST':
        return search_results(search)
    # print(df.to_html())
    template = render_template('index.html', tables=[df.to_html(classes='styled-table')], titles=df.columns.values,
                               form=search)
    # print(template)
    return template


@app.route('/search')
def search_results(search):
    df = connection()
    # print(df.columns)
    if search.data['search'] == '':
        template = render_template('index.html', tables=[df.to_html(classes='styled-table')], titles=df.columns.values,
                                   form=search)
        return template
    else:
        most_similar = process.extractOne(search.data['search'], df.get(search.data['select']), scorer=fuzz.WRatio)
        print(f"accuracy: {most_similar[1]}")
        if most_similar[1] > 85.0:
            column = str(search.data['select'])
            # print(df[column])
            result = df.loc[df[column].isin([most_similar[0]])]
            template = render_template('results.html', tables=[result.to_html(classes='styled-table')],
                                       titles=result.columns.values, form=search)
            return template
        else:
            template = render_template('index.html', tables=[df.to_html(classes='styled-table')],
                                       titles=df.columns.values, form=search)
            return template


if __name__ == "__main__":
    # app.run(debug=True)  # showing live changes
    app.static_folder = 'static'
    app.run()
