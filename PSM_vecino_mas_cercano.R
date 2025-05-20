library(MatchIt) 
library(cobalt)

# -------------------------
# Paso 1: Estimar el propensity score y emparejar
# -------------------------
# mi_base = son tus datos
# "tratamiento" es la variable binaria (1 = recibió intervención, 0 = no)
# Las variables a la derecha de la ~ son covariables (edad, ingreso, escolaridad, etc.)

modelo <- matchit(
  tratamiento ~ edad + escolaridad,  # ajusta tus covariables aquí
  data = mi_base,
  method = "nearest"  # método del vecino más cercano (1:1 por defecto)
)

# -------------------------
# Paso 2: Balance antes y después
# -------------------------
summary(modelo) 

# -------------------------
# Paso 3: Gráfica para visualizar si las covariables quedaron balanceadas
# -------------------------
love.plot(modelo, binary = "std", thresholds = c(m = 0.1))

# -------------------------
# Paso 4: Generar base emparejada
# -------------------------
base_emparejada <- match.data(modelo)

# -------------------------
# Paso 5: Analizar el efecto del tratamiento
# -------------------------
# Cambia "resultado" por tu variable de interés (ingreso, satisfacción, empleo, etc.)
t.test(resultado ~ tratamiento, data = base_emparejada)
