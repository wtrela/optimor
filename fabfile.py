import os

from fabric.api import *

@task(name='app')
def build_app():
    local('docker build -f ./Dockerfile -t app ./')


@task(name='test')
def run_tests():
    pass


@task(name='all')
def build_all():
    build_app()


@task(name='bootstrap')
def bootstrap():
    build_all()
    local('docker-compose up -d')

