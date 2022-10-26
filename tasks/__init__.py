from invoke import Collection

from . import env
from . import format as format_

ns = Collection()
ns.add_collection(env)
ns.add_collection(format_)
