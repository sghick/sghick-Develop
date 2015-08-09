//
//  SqlHeader.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#ifndef Demo_SMFrameWork_SqlHeader_h
#define Demo_SMFrameWork_SqlHeader_h

#define sql_delete_jokes_with_uid @"DELETE tb_joke WHERE uid=:uid"
#define sql_search_jokes_with_uid @"SELECT * tb_joke JOKE WHERE uid=:uid"

#endif
