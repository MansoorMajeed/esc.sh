# Esc.sh Blog Source


## Set up locally

```
git submodule init
git submodule update -r
```

if for whatever reason it does not work and the `themes/hugo-coder` directory is empty, then run

```
git submodule add https://github.com/luizdepra/hugo-coder.git themes/hugo-coder
hugo
```

## In production

Runs via Github pages (the github action definition can be found under `.github/workflows/hugo.yml`)
