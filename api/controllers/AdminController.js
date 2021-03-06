const path = require('path')
const fs = require('fs');

/**
 * SesionController
 *
 * @description :: Server-side actions for handling incoming requests.
 * @help        :: See https://sailsjs.com/docs/concepts/actions
 */

module.exports = {

  inicioSesion: async (peticion, respuesta) => {
    respuesta.view('pages/admin/inicio_sesion')
  },

  procesarInicioSesion: async (peticion, respuesta) => {
    let admin = await Admin.findOne({ email: peticion.body.email, contrasena: peticion.body.contrasena, activo:  true })
    if (admin) {
      peticion.session.admin = admin
      peticion.session.cliente = undefined
      peticion.addFlash('mensaje', 'Sesión de admin iniciada')
      return respuesta.redirect("/admin/principal")
    }
    else {
      peticion.addFlash('mensaje', 'Email o contraseña invalidos / Usuario desactivado')
      return respuesta.redirect("/admin/inicio-sesion");
    }
  },

  principal: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash('mensaje', 'Sesión inválida')
      return respuesta.redirect("/admin/inicio-sesion")
    }
    let fotos = await Foto.find().sort("id")
    respuesta.view('pages/admin/principal', { fotos })
  },

  clientes: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash('mensaje', 'Sesión inválida')
      return respuesta.redirect("/admin/inicio-sesion")
    }   
    let clientes = await Cliente.find().sort("id")
    respuesta.view('pages/admin/clientes', { clientes })  
  },

  ordenes: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash('mensaje', 'Sesión inválida')
      return respuesta.redirect("/admin/inicio-sesion")
    }   
    let ordenes = await Orden.find({ cliente: peticion.params.clienteId }).sort('id desc')
    let cliente = await Cliente.findOne({ id: peticion.params.clienteId })
    respuesta.view('pages/admin/ordenes', { ordenes, cliente })  
  },

  fotos: async (peticion, respuesta) => {

    let consulta = `
    SELECT
      foto.id,
      foto.titulo,
      foto.contenido,
      foto.activa
    FROM
      orden_detalle detalle
      INNER JOIN foto ON detalle.foto_id = foto.Id  
    WHERE  
      detalle.orden_id = $1
    `
    await OrdenDetalle.query(consulta, [peticion.params.ordenId], (errores, resultado) => {
      let fotos = resultado.rows
      respuesta.view('pages/admin/fotos', { fotos })
    })
  },

  administradores: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash('mensaje', 'Sesión inválida')
      return respuesta.redirect("/admin/inicio-sesion")
    }   
    let administradores = await Admin.find().sort("id")
    respuesta.view('pages/admin/administradores', { administradores })  
  },

  dashboard: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash('mensaje', 'Sesión inválida')
      return respuesta.redirect("/admin/inicio-sesion")
    }   
    let clientes = await Cliente.count()
    let fotos = await Foto.count()
    let administradores = await Admin.count()
    let ordenes = await Orden.count()    
    

    respuesta.view('pages/admin/dashboard', { clientes, fotos, administradores, ordenes })  
  },

  cerrarSesion: async (peticion, respuesta) => {
    peticion.session.admin = undefined
    peticion.addFlash('mensaje', 'Sesión finalizada')
    return respuesta.redirect("/");
  },

  agregarFoto: async (peticion, respuesta) => {
    respuesta.view('pages/admin/agregar_foto')
  },

  procesarAgregarFoto: async (peticion, respuesta) => {
    let foto = await Foto.create({
      titulo: peticion.body.titulo,
      activa: true
    }).fetch()
    peticion.file('foto').upload({}, async (error, archivos) => {
      if (archivos && archivos[0]) {
        let upload_path = archivos[0].fd
        let ext = path.extname(upload_path)

        await fs.createReadStream(upload_path).pipe(fs.createWriteStream(path.resolve(sails.config.appPath, `assets/images/fotos/${foto.id}${ext}`)))
        await Foto.update({ id: foto.id }, { contenido: `${foto.id}${ext}` })
        peticion.addFlash('mensaje', 'Foto agregada')
        return respuesta.redirect("/admin/principal")
      }
      peticion.addFlash('mensaje', 'No hay foto seleccionada')
      return respuesta.redirect("/admin/agregar-foto")
    })
  },

  desactivarFoto: async (peticion, respuesta) => {
    await Foto.update({id: peticion.params.fotoId}, {activa: false})
    peticion.addFlash('mensaje', 'Foto desactivada')
    return respuesta.redirect("/admin/principal")
  },

  activarFoto: async (peticion, respuesta) => {
    await Foto.update({id: peticion.params.fotoId}, {activa: true})
    peticion.addFlash('mensaje', 'Foto activada')
    return respuesta.redirect("/admin/principal")
  },

  activarCliente: async (peticion, respuesta) => {
    await Cliente.update({id: peticion.params.clienteId}, {activo: true})
    peticion.addFlash('mensaje', 'Cliente Activado')
    return respuesta.redirect("/admin/clientes")
  },

  desactivarCliente: async (peticion, respuesta) => {
    await Cliente.update({id: peticion.params.clienteId}, {activo: false})
    peticion.addFlash('mensaje', 'Cliente Desactivado')
    return respuesta.redirect("/admin/clientes")
  },

  activarAdministrador: async (peticion, respuesta) => {
    await Admin.update({id: peticion.params.administradorId}, {activo: true})
    peticion.addFlash('mensaje', 'Administrador Activado')
    return respuesta.redirect("/admin/administradores")
  },

  desactivarAdministrador: async (peticion, respuesta) => {
    await Admin.update({id: peticion.params.administradorId}, {activo: false})
    peticion.addFlash('mensaje', 'Administrador Desactivado')
    return respuesta.redirect("/admin/administradores")
  },

};

