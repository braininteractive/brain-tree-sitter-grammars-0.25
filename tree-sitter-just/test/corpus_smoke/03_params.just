release tag=version:
    git tag {{tag}}
    git push origin {{tag}}

deploy env="staging" *args:
    ./deploy.sh {{env}} {{args}}
