package org.acme.quickstart;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class SaludosService {

  public String greeting(String name) {

    return "hola " + name;
  }

}
