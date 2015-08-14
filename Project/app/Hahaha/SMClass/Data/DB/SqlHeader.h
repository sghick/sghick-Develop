//
//  SqlHeader.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#ifndef Demo_SMFrameWork_SqlHeader_h
#define Demo_SMFrameWork_SqlHeader_h

#define sql_delete_jokes_with_uid   @"DELETE tb_joke WHERE uid=:uid"
#define sql_set_jokes_read_with_uid @"UPDATE tb_joke SET read = true WHERE uid=:uid"
#define sql_search_jokes_with_uid   @"SELECT * FROM tb_joke WHERE uid=:uid"

#endif
