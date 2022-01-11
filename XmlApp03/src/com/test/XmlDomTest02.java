/*=========================
 * XmlDomTest02.java
 * - 콘솔 기반 자바 프로그램
 * - XML DOM 활용 → 로컬 XML 읽어내기
 * 	 (memberList.xml)
========================== */

package com.test;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlDomTest02
{
	public static void main(String[] args)
	{
		try
		{
			/////
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document xmlObj = null;
			
			/////
			String url = "memberList.xml";
			xmlObj = builder.parse(url);
			
			Element root = xmlObj.getDocumentElement();
			
			/////
			NodeList memberListNodeList = root.getElementsByTagName("memberInfo");
			
			
			for(int i=0; i<memberListNodeList.getLength(); i++)	
			{
				Node memberInfoNode =  memberListNodeList.item(i);	
				
				////
				Element memberElement = (Element)memberInfoNode;
				
				System.out.printf("%s %s%n", getText(memberElement, "name") , getText(memberElement, "telephone"));
				
				// 컬리큘럼 추가---------------------------------
				
				// memberInfoElement로 부터 curriculumn NodeList 얻어오기
				NodeList curriculumList = memberElement.getElementsByTagName("curriculumn");
				
				if(curriculumList.getLength() > 0)
				{
					Node curriculumnNode = curriculumList.item(0);
					Element curriculumnElement = (Element)curriculumnNode;
					
					// 방법 1.
					/*NodeList subNodeList = curriculumnElement.getElementsByTagName("sub");
					for(int m=0; m <subNodeList.getLength(); m++)
					{
						Node subNode = subNodeList.item(m);
						Element subElement =  (Element)subNode;
						System.out.printf("%s ", subElement.getTextContent());
					}
					System.out.println();
					*/
					
					
					// 방법 2.
					/*
					 -----------------------------------------
					 Node Type   Named Constent
					 -----------------------------------------
					  1			 ELEMENT_NODE
					  2			 ATTRIBUTE_NODE
					  3			 TEXT_NODE
					  4			 CDATA_SECTION_NODE
					  5 		 ENTITY_REFERENCE_NODE
					  6			 ENTITY_NODE
					  7		 	 PROCESSING_INSTRUCTION_NODE
					  8			 COMMENT_NODE
					  9			 DOCUMNET_NODE
					 10			 DOCUMENT_TYPE_NODE
					 11 		 DOCUMENT_FRAGMENT_NODE
					 12			 NOTATION_NODE
					 -----------------------------------------
					 
					 */
					
					NodeList subNodeList = curriculumnElement.getChildNodes(); //★★CHECK★★
					for(int m=0; m<subNodeList.getLength(); m++)
					{
						Node subNode = subNodeList.item(m);
						if(subNode.getNodeType() == 1)		// ELEMENT_NODE 	//★★CHECK★★	
						{
							Element subElement = (Element)subNode;
							System.out.printf("%s", subElement.getTextContent());
						}	
					}	
					System.out.println();
				}
				
				// ----------------------------- 컬리큘럼 추가 
			}
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
	}///end main
	
	public static String getText(Element parent, String tagName)
	{
		String result = "";
		
		Node node = parent.getElementsByTagName(tagName).item(0);
		Element element = (Element)node;
		
		result = element.getChildNodes().item(0).getNodeValue();
		
		return result;
	}
	
}
