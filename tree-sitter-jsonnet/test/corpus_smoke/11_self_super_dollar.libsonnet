// self, super, and $ references.
local parent = {
  name: "parent",
  describe(): "I am " + self.name,
};

{
  root_marker: "root",
  child: parent + {
    name: "child",
    parent_name: super.name,
    described: super.describe(),
    from_root: $.root_marker,
    has_name: "name" in super,
  },
}
