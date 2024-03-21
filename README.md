# Calculadora de Inversión en Criptomonedas

Esta aplicación web permite a los usuarios definir un balance en dólares para invertir en Bitcoin (BTC), Ether (ETH) y Cardano (ADA), calculando la ganancia anual proyectada para cada criptomoneda basada en retornos mensuales específicos. Además, muestra el balance final proyectado en dólares y su equivalente en criptomonedas. La aplicación también presenta una tabla actualizada en tiempo real con información sobre estas tres criptomonedas, con opciones para exportar los datos a CSV y JSON.

## Características

- Calculadora de inversión para BTC, ETH y ADA con ganancias anuales proyectadas.
- Visualización del balance final proyectado en dólares.
- Tabla en tiempo real con información actualizada sobre BTC, ETH y ADA.
- Opción de exportar datos de la tabla en formatos CSV y JSON.

## Tecnologías Utilizadas

- Ruby on Rails 
- JavaScript
- API de CoinAPI para datos en tiempo real de criptomonedas.
- Webscokets usando Action Cable para actualizaciones en tiempo real.
- Sidekiq para procesamiento en segundo plano.
- Rspec para testing

## Configuración

Para configurar y ejecutar este proyecto localmente, sigue estos pasos:

```bash
git clone https://github.com/<tu_usuario>/<tu_repositorio>.git
cd <tu_repositorio>
bundle install
yarn install
rails db:create db:migrate
```

Hay que configurar la coinapi **API-KEY** y la **BASE_URL** desde Rails.application.credentials

Para correr los spec
```bash
bundle exec rspec

```

Para correr los workers que actualizan los precios en tiempo real 
```bash
bundle exec sidekiq

```



