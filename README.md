# InsolvGestión

Aplicación web full-stack en español para gestionar clientes, expedientes, acreedores, obligaciones, archivos privados, contratos, pagos, calendario, tareas, recordatorios, auditoría y borradores asistidos por IA, conforme al PPI `PPI_InsolvGestion_TdeA_2026.docx`.

El nombre de Grupo Jurídico Fénix se conserva porque aparece en el PPI como organización de referencia del proyecto académico. Esta implementación no representa una aprobación, contratación ni puesta en producción de esa organización. Los datos de demostración son ficticios.

## Requisitos

- Node.js 20.19 o posterior.
- pnpm 11.25 o Corepack con pnpm 11.25.
- Docker Desktop con Docker Compose para iniciar PostgreSQL y la aplicación de demostración.

## Inicio local con Docker

1. Copia `.env.example` como `.env` y cambia `CRON_SECRET` y `DEMO_PASSWORD` por valores aleatorios de al menos 32 y 16 caracteres, respectivamente.
2. Inicia los servicios con `docker compose up --build`.
3. Abre `http://localhost:3000`. La base de datos se migra al iniciar la aplicación. Con `SEED_DEMO=true` se cargan registros de prueba ficticios.
4. Inicia sesión con `admin@insolv.local` y la contraseña definida en `DEMO_PASSWORD`. El sistema obliga a cambiarla en el primer acceso.

Las demás cuentas de muestra se llaman `legal@insolv.local`, `operaciones@insolv.local` y `comercial@insolv.local`; comparten la contraseña de demostración y también deben cambiarla. No uses estas credenciales en una instalación real.

Para crear una instancia sin datos de muestra, define `SEED_DEMO=false`, configura `BOOTSTRAP_ADMIN_NAME`, `BOOTSTRAP_ADMIN_EMAIL` y `BOOTSTRAP_ADMIN_PASSWORD` en `.env`, inicia los servicios y ejecuta:

```powershell
docker compose exec app pnpm db:bootstrap-admin
```

La contraseña inicial debe tener entre 16 y 200 caracteres y cambiarse tras ingresar.

## Desarrollo y verificación

Con una base de datos PostgreSQL disponible y variables configuradas en `.env`:

```powershell
pnpm install
pnpm db:generate
pnpm db:deploy
pnpm db:seed
pnpm dev
```

Comandos de calidad:

```powershell
pnpm lint
pnpm typecheck
pnpm test
pnpm env:check
pnpm build
```

La batería E2E se ejecuta con el procedimiento aislado de [instalación local](docs/installation.md), dentro del contenedor `app`. Escribe datos ficticios y usa `E2E_DATABASE_URL` para vencer una sesión en PostgreSQL. No la apuntes a producción ni a datos reales. Consulta [el informe de verificación](docs/verification-report.md) para los resultados y bloqueos reales.

## Documentación

- [Guía de usuario](docs/user-guide.md)
- [Trazabilidad con el PPI](docs/requirements-traceability.md)
- [Arquitectura y decisiones](docs/architecture-and-decisions.md)
- [Seguridad y datos personales](docs/security-and-privacy.md)
- [Operación, respaldo y despliegue](docs/operations.md)
- [Instalación local](docs/installation.md)
- [Guía de despliegue](docs/deployment.md)
- [Respaldo y restauración](docs/backup-and-restore.md)
- [Integraciones externas](docs/integrations.md)
- [Informe de verificación](docs/verification-report.md)

## Alcance responsable

Los estados del expediente son categorías operativas y no determinan actuaciones o efectos jurídicos. El módulo de IA funciona por defecto en modo simulado; las generaciones reales solo usan la plantilla y los hechos que el profesional seleccione y siempre quedan como `BORRADOR` hasta su revisión. El sistema no firma, presenta documentos ni reemplaza el criterio profesional.

El PPI menciona la Ley 1581 de 2012, pero no define políticas aprobadas de retención, eliminación, respuesta a titulares, residencia de datos, hosting o proveedor de IA. Antes de cargar datos reales, la organización debe definir y validar esas políticas y el entorno de despliegue con responsables competentes.
