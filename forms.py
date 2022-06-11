from wtforms import Form, StringField, SelectField


class bookSearchform(Form):
    choices = [('Tytuł Książki', 'Tytuł'),
               ('Nazwisko autora', 'Nazwisko Autora'),
               ('Wydawnictwo', 'Wydawnictwo')]
    select = SelectField('Search for books:', choices=choices)
    search = StringField('')
