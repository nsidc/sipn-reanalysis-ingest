import requests

from sipn_reanalysis_ingest.constants.creds import RDA_USER, RDA_PASSWORD
from sipn_reanalysis_ingest.constants.download import DOWNLOAD_AUTH_URL


def rda_auth_session() -> requests.Session:
    session = requests.Session()

    session.post(
        DOWNLOAD_AUTH_URL,
        data={
            'action': 'login',
            'email': RDA_USER,
            'passwd': RDA_PASSWORD,
        },
    )

    return session
