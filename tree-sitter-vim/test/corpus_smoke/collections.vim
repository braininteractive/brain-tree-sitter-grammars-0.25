" Lists and dictionaries.
let s:list = [1, 2, 3, 'four', [5, 6]]
let s:empty = []
let s:dict = {'name': 'vim', 'year': 1991, 'tags': ['editor', 'modal']}
let s:nested = {'outer': {'inner': {'value': 42}}}
let s:first = s:list[0]
let s:slice = s:list[1:2]
let s:name = s:dict['name']
let s:year = s:dict.year
call add(s:list, 7)
call extend(s:dict, {'license': 'charityware'})
let s:keys = keys(s:dict)
echo len(s:list) + len(s:keys)
