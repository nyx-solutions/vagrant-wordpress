# NYX / Vagrant WordPress

## Instalação

Para adicionar em um projeto Git já inicializado, navegue até a pasta do projeto e execute:

```bash

git submodule add git@github.com:nyx-solutions/vagrant-wordpress.git vagrant-wordpress

bash ./vagrant-wordpress/install

```

Após o passo acima, rode:

```bash

vagrant up --provision

```

Para atualizar a box, rode:

```bash

vagrant box update

```
