import datetime as dt

import click


class DateParameter(click.ParamType):
    """Support date parameters in Click CLIs.

    Click currently only supports datetimes out of the box.
    """

    name = 'date'

    def __init__(self, formats=None):
        self.formats = formats or [
            '%Y-%m-%d',
            '%Y%m%d',
        ]

    def __repr__(self):
        return 'Date'

    def get_metavar(self, param):
        formats_str = "|".join(self.formats)
        return f'[{formats_str}]'

    def convert(self, value, param, ctx):
        for fmt in self.formats:
            try:
                return dt.datetime.strptime(value, fmt).date()
            except ValueError:
                continue

        self.fail(f'{value} is not a valid date. Expected one of: {self.formats}')


class MonthParameter(DateParameter):
    """Support month parameters in Click CLIs.

    Year and month are expected. The final value is a `dt.date(YYYY, MM, 1)`.
    """

    name = 'month'

    def __init__(self, formats=None):
        default = ['%Y-%m', '%Y%m']
        self.formats = formats or default

    def __repr__(self):
        return 'Month'
