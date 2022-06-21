const path = require('path');

module.exports = ({env}) => {
  if (env('DATABASE_CLIENT') === 'sqlite') {
    return {
      connection: {
        client: 'sqlite',
        connection: {
          filename: path.join(__dirname, '..', env('DATABASE_FILENAME', '.tmp/data.db')),
        },
        useNullAsDefault: true,
      },
    }
  } else {
    return {
      connection: {
        client: env('DATABASE_CLIENT'),
        connection: {
          host: env('DATABASE_HOST'),
          port: env('DATABASE_PORT'),
          database: env('DATABASE_NAME'),
          user: env('DATABASE_USERNAME'),
          password: env('DATABASE_PASSWORD'),
          ssl: false,
        },
        debug: false,
      }
    }
  }
};

