package com.fengling.cms.manager.main;

import com.fengling.cms.entity.main.Content;
import com.fengling.cms.entity.main.ContentTxt;

public interface ContentTxtMng {
	public ContentTxt save(ContentTxt txt, Content content);

	public ContentTxt update(ContentTxt txt, Content content);
}