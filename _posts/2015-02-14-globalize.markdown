---
layout: post
title: globalize
tags:
- gem
---

[globalize][1] is a library to solve multi languages problem based on
ActiveRecord.

Rails I18n solution is based on yaml files, it is good for some
hardcoded content (like Register / 注册), but it doesn't help to the
content in databsae.

globalize provides an awesome solution, e.g. we have a Hospital model,
name needs to be multi languages.

```
class Hospital < ActiveRecord::Base
  translates :name
end
```

It will generate a new hospital_translations table.

| id | hospital_id | name | locale |
| ----- | ----- | ----- | ----- |
| 1 | 1 | Ruijin Hospital | en-US |
| 1 | 1 | 瑞金医院 | zh-CN |

globalize will read and save content based on current I18n.locale, you
almost don't need to write any customized code, it's integrated into
rails seamlessly.

globalize also provide migration helpers to create translations tables
and migrate data.

```
class CreateHospitalTranslations < ActiveRecord::Migration
  def up
    Hospital.create_translation_table!({ :name => :string }, { :migrate_data => true })
  end

  def down
    Hospital.drop_translation_table!
  end
end
```

globalize is one of the best choices for multi language rails
websites.

[1]: https://github.com/globalize/globalize
