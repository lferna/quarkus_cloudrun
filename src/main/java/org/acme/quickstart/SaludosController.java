package org.acme.quickstart;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Contact;
import org.eclipse.microprofile.openapi.annotations.info.Info;
import org.eclipse.microprofile.openapi.annotations.info.License;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

@Path("/hola")
@OpenAPIDefinition(tags = {
@Tag(name = "widget", description = "Widget operations."),
@Tag(name = "gasket", description = "Operations related to gaskets")
}, info = @Info(title = "Example API", version = "1.0.1", contact = @Contact(name = "Example API Support", url = "http://exampleurl.com/contact", email = "techsupport@example.com"), license = @License(name = "Apache 2.0", url = "http://www.apache.org/licenses/LICENSE-2.0.html")))
public class SaludosController {

  @Inject
  SaludosService service;

  @GET
  @Produces(MediaType.TEXT_PLAIN)
  @Path("/{nombre}")
  public String crearSaludo(@PathParam String nombre) {
    this.service.crearSaludo(nombre);
    String salida="Hola "+nombre+". Tu saludo ha sido guardado. ";
    Long numero = this.service.contarSaludo(nombre);
    salida+="Llevas: "+numero+" saludos.";
    return salida;
  }

}