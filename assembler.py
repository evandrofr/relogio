import binascii

dic_instrucoes={
    "MOV":"0000",
    "CMP":"0001",
    "INC":"0010",
    "LOAD":"0011",
    "STORE":"0100",
    "JE":"01010000",
    "JMP":"01100000"
}
dic_registradores={
    "R0":"0000",
    "R1":"0001",
    "R2":"0010",
    "R3":"0011",
    "R4":"0100",
    "R5":"0101",
    "RA":"0110",
    "RB1":"0111",
    "RB2":"1000",
    "RC":"1001"
}

with open("assembly.txt","r") as content:
    lista=content.readlines()

lista_f=[]
dic_jmp={}
for i in range(len(lista)):
    linha=lista[i].replace(","," ").split()
    if linha[0].endswith(":"):
        dic_jmp[linha[0][:-1]]='{0:08b}'.format(i)
        del linha[0]
    if linha[0]=="INC":
        linha.append("#1")
    lista_f.append(linha)
    
print(lista_f)
def tradutor(palavra):
    if palavra in dic_instrucoes:
        return dic_instrucoes[palavra]
    elif palavra in dic_registradores:
        return dic_registradores[palavra]
    elif palavra in dic_jmp:
        return dic_jmp[palavra]
    else:
        if palavra.startswith("0x"):
            return "{0:08b}".format(int(palavra[2:], 16)) 
        elif palavra.startswith("#"):
            return "{0:08b}".format(int(palavra[1:], 10)) 


with open("binary.txt","w") as content:
    for f in range(len(lista_f)):
        i=lista_f[f]
        line=""
        if i[0]=="STORE":
            i[1],i[2]=i[2],i[1]
        for a in range(len(i)):
            line=line+tradutor(i[a])
            print(line)
        
        print(i)
        content.writelines("tmp({}) := \"{}\";\n".format(f,line))
        print("\n")


