//
//  CClass.c
//  SwiftStudy
//
//  Created by xiejinke on 2016/12/28.
//  Copyright © 2016年 wy. All rights reserved.
//

#include "CClass.h"

void doSomthing() {
    char c[2] = "s";
    char a[10] = {'s','b','a'};
    printf("%s",a);
    char *name = "mochen";
    
    printf("%s,%d",name,sizeof(name));
}
