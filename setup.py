#!/usr/bin/env python

from setuptools import setup

long_description = open('README.md', 'r').read()

setup(
    name="marx",
    version="0.1",
    packages=['marx',],  # This is empty without the line below
    package_data={'marx': ['*.hy'],},
    author="Paul Tagliamonte",
    author_email="paultag@debian.org",
    long_description=long_description,
    description='does some stuff with things & stuff',
    license="Expat",
    url="",
    platforms=['any']
)
