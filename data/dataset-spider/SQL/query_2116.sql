SELECT Ref_Shipping_Agents.shipping_agent_name FROM Ref_Shipping_Agents JOIN Documents ON Documents.shipping_agent_code = Ref_Shipping_Agents.shipping_agent_code WHERE Documents.document_id = 2;