class DownloadError(Exception):
    """Failed to dowload a file."""


class CredentialsError(DownloadError):
    """A credential was not found."""


class CfsrDateError(Exception):
    """There was a problem with a CFSR date."""


class CfsrInputDataError(Exception):
    """There was a problem finding the needed CFSR input data."""


class ProgrammerError(Exception):
    """Encountered an error that should not have happened."""


class RangeLookupError(LookupError):
    """Failed to perform range lookup."""
