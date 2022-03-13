Numeric
-------

- `isclose` and `allclose` -- approximate equality for floating point numbers,
  ported from NumPy

Structs
-------

- `filterFields`, `dropFields`, `selectFields` -- struct manipulation based on
  field names

Plotting
--------

- `pline`, `multipline`, `legendline` -- plotting lines using the `patch`
  command, which has some additional options (like line alpha) not available to
  normal lines
- `fig2raster` -- wrapper around `export_fig` to ease converting figures to
  raster outputs
- `newgrid` -- wrapper around `tiledlayout` for producing styled figures

Strings
-------

- `namedformat` -- use Python-style named identifiers in *printf format strings
- `sentencecase`, `titlecase` -- additional string casing functions
- `slugify` -- make strings safe for use as paths/URIs
- `uuid` -- get a random-ish UUID
- `writestring` -- write string(s) to file

Programming
-----------

- `arrayConstructor` -- mixin class that provides a constructor that behaves 
  like `zeros`, `ones`, etc.
- `partial` -- quick function closures, inspired by Python's `functools.partial`
- `silentWarningWrapper` -- wrap a function to silence a warning
