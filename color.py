list1 = ["#6BBADE",
         # 5
         "#D63333","#C8FF29","#EF65C6","#5AC75A",
         "#E96529","#B848FF","#E98116","#60D5FF",
         "#8C84EF","#E9435A","#F74537","#A5F937",
         "#FA51FF","#47FFC0","#FF7710","#E741D6",
         # 4
         "#3FD3CE","#3FD3CE","#9AC731","#AF5AE3",
         "#FF553C","#F38A4A","#0BDBE1","#E54869",
         "#58C75D","#FF3D01","#39D042","#00C7D6",
         "#F56000","#6BECE9","#FF7D3F","#8E4AE5",
         # 42
         "#EF9329","#8F4AE7","#2CD7B0",
         ]
list2 = ["#0D6991",
         # 5
         "#84131A","#4F9405","#7932A2","#007D3F",
         "#912A10","#5A17AA","#9C4B26","#1B4F91",
         "#553BA7","#89134A","#9C1226","#448121",
         "#861E95","#2199A7","#9F2210","#76206E",
         # 4
         "#1B6791","#1B6791","#6B920B","#7931A5",
         "#CE3010","#D35516","#45B0B0","#B20029",
         "#007D3E","#A32700","#008943","#086D94",
         "#A72D00","#086F70","#BD3400","#54257A",
         # 42
         "#B85C00","#52257E","#219673",
         ]
import math
import numpy as np

def hex_to_rgb(hex_color: str):
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))



def main():
    for it in range(0, len(list1)):
        tup1 = hex_to_rgb(list1[it])
        tup2 = hex_to_rgb(list2[it])
        tup3 = (
            int(math.floor(max(tup1[0]*1/2+tup2[0]*1/2, 0))),
            int(math.floor(max(tup1[1]*1/2+tup2[1]*1/2, 0))),
            int(math.floor(max(tup1[2]*1/2+tup2[2]*1/2, 0))),
            255
            )
        tup4 =  (
            int(math.floor(max(tup1[0]*(-1)/4+tup2[0]*5/4, 0))),
            int(math.floor(max(tup1[1]*(-1)/4+tup2[1]*5/4, 0))),
            int(math.floor(max(tup1[2]*(-1)/4+tup2[2]*5/4, 0))),
            255
            )
        tup5 =  (
            int(math.floor(min(tup2[0]*(-1)/4+tup1[0]*5/4, 255))),
            int(math.floor(min(tup2[1]*(-1)/4+tup1[1]*5/4, 255))),
            int(math.floor(min(tup2[2]*(-1)/4+tup1[2]*5/4, 255))),
            255
            )
        print("--------------------",it,"--------------------")
        #print("c2=fc",tup5,",")
        #print("c3=fc",tup3,",")
        #print("outline_color=fc",tup4,",")
        #print("glow_color=fc",tup4,",")

        STR = """
                c2 = fc%s,
		    c3 = fc%s,
		    },
		    {
		        thickness = 2.5 * rs,
  		        outline_color = fc%s
		    },
		    {
		        thickness = 1 * rs,
		        glow_color = fc%s
		    },
"""
        print(STR%(str(tup5),str(tup3),str(tup4),str(tup4)))

if __name__ == "__main__":
    main()