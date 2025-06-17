```ALTER TABLE parametrizacion.dim_activos
ADD COLUMN fecha_registro TIMESTAMP DEFAULT (now() AT TIME ZONE 'UTC' - INTERVAL '5 hours');
```
