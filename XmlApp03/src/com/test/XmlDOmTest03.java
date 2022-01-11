/*=========================
 * XmlDomTest03.java
 * - 콘솔 기반 자바 프로그램
 * - XML DOM 활용 → 로컬 XML 읽어내기
 * 	 (breakfast_menu.xml)
========================== */

// breakfast_menu.xml 파일을 대상으로
/*
■[Belgian Waffles]      $5.95   650칼로리
 - Two of our famous Belgian Waffles with plenty of real maple syrup
--------------------------------------------------------------------------------------------   
■[Strawberry Belgian Waffles]      $7.95   900칼로리
  - Light Belgian waffles covered with strawberries and whipped cream
--------------------------------------------------------------------------------------------   
■[Berry-Berry Belgian Waffles]      $8.95   900칼로리
  - Light Belgian waffles covered with an assortment of fresh berries and whipped cream
--------------------------------------------------------------------------------------------   
          :
          :

 */

// 이와 같은 결과 출력이 이루어질 수 있도록 프로그램을 작성한다.

package com.test;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlDOmTest03
{
	public static void main(String[] args)
	{
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document xmlObj = null;
			
			String url = "breakfast_menu.xml";
			xmlObj = builder.parse(url);
			
			Element root = xmlObj.getDocumentElement();
			NodeList foodNodeList = root.getElementsByTagName("food");
			for(int i=0; i<foodNodeList.getLength(); i++)
			{
				Node foodNode = foodNodeList.item(i);
				Element foodElement = (Element)foodNode;
				
				System.out.printf("■ [%s] %s %s칼로리%n - %s%n"
							, getText(foodElement,"name")
							, getText(foodElement,"price")
							, getText(foodElement,"calories")
							, getText(foodElement,"description"));
						System.out.println("----------------------------------------");	
						
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
	}
	
	public static String getText(Element parent, String tagName)
	{
		// 반환할 결과값
		String result = "";
		
		// 특정 태그 이름을 가진 객체의 첫 번째 자식 노드를 얻어온 다름
		Node node = parent.getElementsByTagName(tagName).item(0);
		Element element = (Element)node;
		
		// 특정 엘리먼트의 자식 노드의 값을 얻어올 수 있도록 처리
		result = element.getChildNodes().item(0).getNodeValue();
		
		// 결과값 반환
		return result;
	}
}
