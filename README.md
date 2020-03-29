# Publish gem Github Action

An action that builds and then publishes a Ruby gem to [rubygems.org](https://rubygems.org).

Will find every `.gemspec` file in current directory and publish a gem for it.

## Usage

```yaml
on:
  push:
    tags:
      - '*'

---

- name: Publish gem
  uses: dawidd6/action-publish-gem@v1
  with:
    api_key: ${{secrets.RUBYGEMS_API_KEY}}
```
