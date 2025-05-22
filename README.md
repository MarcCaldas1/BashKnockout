# BashKnockout

Un juego de combate por turnos escrito en Bash, con personajes únicos, habilidades especiales y efectos de estado.

## 🎮 Características

- **5 personajes jugables** con estilos de combate únicos
- **Sistema de efectos de estado**: Veneno, Quemadura, Aturdimiento, etc.
- **Habilidades especiales** por personaje (1 por combate)
- **IA inteligente** con comportamientos adaptativos
- **Interfaz colorida** con ASCII art y barras de vida
- **Efectos de sonido** *(opcional)*

## 👥 Personajes

| Personaje          | Ataque Básico          | Ataque Secundario       | Habilidad Especial       |
|--------------------|------------------------|-------------------------|--------------------------|
| **Guerrero**       | Golpe Devastador (25)  | Embate Escudado (10)    | Ira del Guerrero (+10 daño) |
| **Mago**           | Llama Arcana (15)      | Rayo Concentrado (15)   | Esfera de Protección (Inmune) |
| **Esqueleto**      | Corte Crujiente (18)   | Polvo Infecto (18 + Veneno) | Resurrección (Auto-revive) |
| **Arquero**        | Flecha Precisa (20)    | Flecha Venenosa (10 + Veneno) | Disparo Fantasma (25 + Inmune) |
| **Guardián Arbóreo**| Martillazo (18)      | Enredaderas (10)        | Corazón del Bosque (Cura + Daño) |

## ⚙️ Requisitos

- **Bash** (v4.0 o superior)
- Terminal compatible con colores ANSI
- Linux/macOS (o Windows con WSL/Cygwin)

## 🚀 Instalación y Ejecución

```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-usuario/turn-based-combat-bash.git

# 2. Navegar al directorio
cd turn-based-combat-bash

# 3. Dar permisos de ejecución
chmod +x combat_game.sh

# 4. Ejecutar el juego
./combat_game.sh
