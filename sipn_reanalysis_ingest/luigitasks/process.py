import logging

import luigi

from sipn_reanalysis_ingest.constants.date import DEFAULT_PROCESSING_DAY

logger = logging.getLogger('luigi-interface')


class ProcessDate(luigi.WrapperTask):
    """Wraps processing needed to create an output for a given date."""

    date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    def requires(self):
        ...
