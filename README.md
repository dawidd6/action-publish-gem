# Publish gem Github Action

An action that builds and then publishes a Ruby gem to [rubygems.org](https://rubygems.org).

## Usage

```yaml
on:
  push:
    tags:
      - '*'

---

- name: Publish gem
  uses: dawidd6/action-publish-gem@master
  with:
    api_key: ${{secrets.RUBYGEMS_API_KEY}}
```
