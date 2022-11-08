class DownloadError(Exception):
    """Failed to dowload a file."""


class CredentialsError(DownloadError):
    """A credential was not found."""


class ProgrammerError(Exception):
    """This should not have happened."""


class RangeLookupError(LookupError):
    """Failed to perform range lookup."""
