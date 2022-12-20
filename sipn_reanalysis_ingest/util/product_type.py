from sipn_reanalysis_ingest._types import CfsrGranuleProductType


def cfsr_product_type_prefix(product_type: CfsrGranuleProductType) -> str:
    if product_type is CfsrGranuleProductType.ANALYSIS:
        # nl = analysis
        return 'pgbhnl.gdas'
    elif product_type is CfsrGranuleProductType.FORECAST:
        # 06 = 6-hour forecast
        return 'pgbh06.gdas'
