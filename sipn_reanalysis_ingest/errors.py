class DownloadError(Exception):
    """Failed to dowload a file."""


class CredentialsError(DownloadError):
    """A credential was not found."""


class CfsrInputDataError(Exception):
    """There was a problem finding the needed CFSR input data."""


class ProgrammerError(Exception):
    """This should not have happened."""


class RangeLookupError(LookupError):
    """Failed to perform range lookup."""
