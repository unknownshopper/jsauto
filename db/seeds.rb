# Crear usuarios por defecto

# Admin
User.create!(
  email: 'admin@jsauto.com',
  password: 'GARPRI01',
  password_confirmation: 'GARPRI01',
  role: :admin
)

# Usuario regular
User.create!(
  email: 'usuario@jsauto.com',
  password: 'GARPRI01',
  password_confirmation: 'GARPRI01',
  role: :usuario
)

# Usuario de almacén
User.create!(
  email: 'almacen@jsauto.com',
  password: 'GARPRI01',
  password_confirmation: 'GARPRI01',
  role: :almacen
)
