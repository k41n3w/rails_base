# rails_base
Rails base

![Ruby](https://github.com/kaioramos/rails_base/workflows/Ruby/badge.svg) ![Brakeman Scan](https://github.com/kaioramos/rails_base/workflows/Brakeman%20Scan/badge.svg)

#### Create Application
```bash
$ docker-compose run web rails new . --force --no-deps --database=postgresql
```

#### Create Application in API Mode
```bash
$ docker-compose run web rails new . --api --force --no-deps --database=postgresql
```
