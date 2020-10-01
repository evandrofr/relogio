import keyboard

memoria = [0]*10
reg_a = 0 
switch_ajuste = False
switch_turbo = False
clock = 1

while True:
    if reg_a > 10000 and not switch_turbo:
        memoria[9] += 1
        if memoria[9] > 9: CMP R0, #9
                           JG SOMASEGUNDO
            memoria[9] = 0
            memoria[8] += 1
        if memoria[8] > 5:
            memoria[8] = 0
            memoria[7] += 1
        if memoria[7] > 9:
            memoria[7] = 0
            memoria[6] += 1
        if memoria[6] > 5:
            memoria[6] = 0
            memoria[5] += 1
        if memoria[5] > 9 and memoria[4] == 0:
            memoria[5] = 0
            memoria[4] += 1
        if memoria[5] > 9 and memoria[4] == 1:
            memoria[5] = 0
            memoria[4] += 1
        if memoria[5] > 3 and memoria[4] == 2:
            memoria[5] = 0
            memoria[4] = 0
        print("{0}{1}:{2}{3}:{4}{5}".format(memoria[4],memoria[5],memoria[6],memoria[7],memoria[8],memoria[9]))
        reg_a = 0
        
    if reg_a > 1000 and switch_turbo:
        memoria[9] += 1
        if memoria[9] > 9:
            memoria[9] = 0
            memoria[8] += 1
        if memoria[8] > 5:
            memoria[8] = 0
            memoria[7] += 1
        if memoria[7] > 9:
            memoria[7] = 0
            memoria[6] += 1
        if memoria[6] > 5:
            memoria[6] = 0
            memoria[5] += 1
        if memoria[5] > 9 and memoria[4] == 0:
            memoria[5] = 0
            memoria[4] += 1
        if memoria[5] > 9 and memoria[4] == 1:
            memoria[5] = 0
            memoria[4] += 1
        if memoria[5] > 3 and memoria[4] == 2:
            memoria[5] = 0
            memoria[4] = 0
        print("{0}{1}:{2}{3}:{4}{5}".format(memoria[4],memoria[5],memoria[6],memoria[7],memoria[8],memoria[9]))
        reg_a = 0

    while switch_ajuste:
        try:  # used try so that if user pressed other than the given key error will not be shown
            if keyboard.is_pressed("w"):  # if key 'w' is pressed
                print("sair")
                switch_ajuste = False
            if keyboard.is_pressed("s"):  # if key 'a' is pressed
                memoria[7] += 1
                if memoria[7] > 9:
                    memoria[7] = 0
                    memoria[6] += 1
                if memoria[6] > 5:
                    memoria[6] = 0
                    memoria[7] = 0
                print("{0}{1}:{2}{3}:{4}{5}".format(memoria[4],memoria[5],memoria[6],memoria[7],memoria[8],memoria[9]))
            if keyboard.is_pressed("a"):  # if key 's' is pressed
                memoria[5] += 1
                if memoria[5] > 9 and memoria[4] == 0:
                    memoria[5] = 0
                    memoria[4] += 1
                if memoria[5] > 9 and memoria[4] == 1:
                    memoria[5] = 0
                    memoria[4] += 1
                if memoria[5] > 3 and memoria[4] == 2:
                    memoria[5] = 0
                    memoria[4] = 0
                print("{0}{1}:{2}{3}:{4}{5}".format(memoria[4],memoria[5],memoria[6],memoria[7],memoria[8],memoria[9]))
                
            
        except:
            print("Pressione w para sair de ajustar")
            break

 
    try:  # used try so that if user pressed other than the given key error will not be shown
        if keyboard.is_pressed("q"):  # if key 'q' is pressed
            print("Ajuste") 
            switch_ajuste = True
            
    except:
        print("Pressione q para ajustar")
        break

    try:  # used try so that if user pressed other than the given key error will not be shown
        if keyboard.is_pressed("z"):  # if key 'z' is pressed
            print("Turbo") 
            switch_turbo = not switch_turbo
            
    except:
        print("Pressione q para ajustar")
        break

    
    reg_a += clock
