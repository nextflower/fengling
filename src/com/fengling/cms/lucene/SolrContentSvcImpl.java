package com.fengling.cms.lucene;

import org.springframework.stereotype.Component;

import com.fengling.cms.entity.main.Channel;
import com.fengling.cms.entity.main.Content;
import com.fengling.core.entity.CmsSite;
import com.fengling.search.solrmodule.query.EPSSolrServerForFengLing;
import com.fengling.search.solrmodule.write.EpsSolrDocument;

@Component
public class SolrContentSvcImpl implements SolrContentSvc {
	
	private EPSSolrServerForFengLing server = new EPSSolrServerForFengLing();

	public void createIndex(Content c) {
		EpsSolrDocument doc = createDocument(c);
		server.addDocument(doc, false);
	}

	public void deleteIndex(Content c) {
		server.deleteById(String.valueOf(c.getId()));
	}

	public void updateIndex(Content c) {
		deleteIndex(c);
		createDocument(c);
	}
	
	private EpsSolrDocument createDocument(Content content) {
		Channel channel = content.getChannel();
		CmsSite site = content.getSite();
		EpsSolrDocument doc = new EpsSolrDocument();
		doc.addField(ID, content.getId());
		return doc;
	}
	

	public static final String ID = "ID";//主键

}
