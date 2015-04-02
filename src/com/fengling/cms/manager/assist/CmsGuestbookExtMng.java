package com.fengling.cms.manager.assist;

import com.fengling.cms.entity.assist.CmsGuestbook;
import com.fengling.cms.entity.assist.CmsGuestbookExt;

public interface CmsGuestbookExtMng {
	public CmsGuestbookExt save(CmsGuestbookExt ext, CmsGuestbook guestbook);

	public CmsGuestbookExt update(CmsGuestbookExt ext);
}