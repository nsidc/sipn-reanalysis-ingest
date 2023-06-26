from invoke import Collection

from . import env, test

ns = Collection()
ns.add_collection(env)
ns.add_collection(test)
