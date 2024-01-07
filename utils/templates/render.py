from jinja2 import Environment, FileSystemLoader

env = Environment(
    loader = FileSystemLoader(""),
    lstrip_blocks = True,
    trim_blocks = True
)
template = env.get_template("Pointer.hsc.jinja")
print(template.render())
