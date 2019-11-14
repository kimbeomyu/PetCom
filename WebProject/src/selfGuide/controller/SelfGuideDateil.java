package selfGuide.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import selfGuide.model.service.SelfGuideService;
import selfGuide.model.vo.SelfGuide;

/**
 * Servlet implementation class SelfGuideDateil
 */
@WebServlet("/selfGuideDateil")
public class SelfGuideDateil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelfGuideDateil() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int selfNo = Integer.parseInt(request.getParameter("selfNo"));
		new SelfGuideService().viewCount(selfNo);

		SelfGuide guideOne = new SelfGuideService().detailGuide(selfNo);
		RequestDispatcher view = request.getRequestDispatcher("/views/selfGuide/selfGuideDetail.jsp");
		request.setAttribute("guideOne", guideOne);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
