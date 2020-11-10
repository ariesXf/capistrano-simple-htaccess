# Changelog

### master

### v1.0.0, 2020-11-10

- Refactor default `.htaccess` file to externally redirect out of capistrano's 'current' directory
  - This requires setting a new `:document_root` variable so the new  `.htaccess` file can function
  - `:document_root` should be set to what your Apache's `DocumentRoot` is set to. The rake task will use this to dynamically build the `.htaccess`

### v0.1.1, 2020-03-17

- Run Rubocop formatters on source
- Bump dependency version requirements

### v0.1.0, 2019-03-06

- Initial version
