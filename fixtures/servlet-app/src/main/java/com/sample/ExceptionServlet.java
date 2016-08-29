package com.example.managedvms.helloworld;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "exceptionServlet", value = "/exception")
@SuppressWarnings("serial")
public class ExceptionServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    throw new RuntimeException("Runtime exception purposely thrown in ExceptionServlet");
  }

}
