#!/bin/bash

# === COLORES ===
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # sin color

# Función para mostrar barra de vida
BarraVida() {
  local vida_actual=$1
  local vida_maxima=$2
  local ancho_barra=20  # Ancho de la barra en caracteres

  # Calcula el porcentaje de vida
  local porcentaje=$((vida_actual * 100 / vida_maxima))
  
  # Calcula cuántos caracteres de la barra estarán llenos
  local caracteres_llenos=$((vida_actual * ancho_barra / vida_maxima))
  local caracteres_vacios=$((ancho_barra - caracteres_llenos))
  
  # Construye la barra
  local barra_llena=$(printf "%${caracteres_llenos}s" | tr ' ' '▇')
  local barra_vacia=$(printf "%${caracteres_vacios}s" | tr ' ' '_')
  
  # Color según la vida restante
  if [[ $porcentaje -gt 50 ]]; then
    color=$GREEN
  elif [[ $porcentaje -gt 20 ]]; then
    color=$YELLOW
  else
    color=$RED
  fi
  
  echo -e "${color}[${barra_llena}${barra_vacia}] ${porcentaje}%${NC}"
}

Menu(){
  while true; do
    clear
    echo -e "${BLUE}***** Simulador de Combate por Turnos *****${NC}"
    echo -e "Elige una opción (1-4):"
    echo -e "${GREEN}1. Ir al combate${NC}"
    echo -e "${YELLOW}2. Ver los personajes${NC}"
    echo -e "${CYAN}3. ¿De qué trata?${NC}"
    echo -e "${RED}4. Salir${NC}"
    read opcion

    case "$opcion" in
      1)
        clear
        echo "Elige tu personaje:"
        echo -e "${RED}1. Guerrero${NC}"
        echo -e "${BLUE}2. Mago${NC}"
        echo -e "${CYAN}3. Esqueleto${NC}"
        echo -e "${GREEN}4. Arquero${NC}"
        echo -e "${YELLOW}5. Guardián Arbóreo${NC}"
        read -p "Opción: " player_choice

        echo "Elige el enemigo:"
        echo -e "${RED}1. Guerrero${NC}"
        echo -e "${BLUE}2. Mago${NC}"
        echo -e "${CYAN}3. Esqueleto${NC}"
        echo -e "${GREEN}4. Arquero${NC}"
        echo -e "${YELLOW}5. Guardián Arbóreo${NC}"
        read -p "Opción: " enemy_choice

        # Inicialización de puntos de salud
        player_ps=100
        enemy_ps=100
        player_special_used=0
        enemy_special_used=0
        player_burn=0
        enemy_burn=0
        player_poison=0
        enemy_poison=0
        player_stun=0
        enemy_stun=0
        player_immune=0
        enemy_immune=0
        player_rage=0
        enemy_rage=0
        player_evade=0
        enemy_evade=0
        enemy_heals_left=3
        player_heals_left=3

        # Selección del personaje del jugador
        case $player_choice in
          1)
            player_name="Guerrero"
            ;;
          2)
            player_name="Mago"
            ;;
          3)
            player_name="Esqueleto"
            ;;
          4)
            player_name="Arquero"
            ;;
          5)
            player_name="Guardián Arbóreo"
            ;;
          *)
            echo -e "${RED}Opción no válida.${NC}"
            continue
            ;;
        esac

        # Selección del personaje enemigo
        case $enemy_choice in
          1)
            enemy_name="Guerrero"
            ;;
          2)
            enemy_name="Mago"
            ;;
          3)
            enemy_name="Esqueleto"
            ;;
          4)
            enemy_name="Arquero"
            ;;
          5)
            enemy_name="Guardián Arbóreo"
            ;;
          *)
            echo -e "${RED}Opción no válida.${NC}"
            continue
            ;;
        esac
        
        # Combate
        echo -e "${BLUE}*** COMBATE INICIADO ***${NC}"

        while [[ $player_ps -gt 0 && $enemy_ps -gt 0 ]]; do
          clear
          # Mostrar personaje del jugador
          case $player_name in
            "Guerrero")
              echo -e "${GREEN}Tú (Guerrero):${NC}"
              BarraVida $player_ps 100
              echo "
                _|_
               /___╲
               |o o|
               |_^_|
              ╭┴───┴╮
              │╱ ║  │      /
              │  ║  │     /
             ╱   ║   ╲ _ /_
            ╱    ║    ╲_/
                 ║
                ╱|╲
               ╱ | ╲
              "
              ;;
            "Mago")
              echo -e "${GREEN}Tú (Mago):${NC}"
              BarraVida $player_ps 100
              echo "
                 .  
                / \  
               /___\  
               |o o|  
               |_-_|      
              /| |\      
             / | | \    
            @=======@  
             |/   \|  
             /     \  
            /       \  
           ╱         ╲ 
              "
              ;;
            "Esqueleto")
              echo -e "${GREEN}Tú (Esqueleto):${NC}"
              BarraVida $player_ps 100
              echo "
                .-.
               (o.o)     /
                |=|     /
               __|__  _/_
             _/  |  \_/
                 |
                / \  
               /   \ 
              /     ╲
             /       ╲
              "
              ;;
            "Arquero")
              echo -e "${GREEN}Tú (Arquero):${NC}"
              BarraVida $player_ps 100
              echo "
                
                   /\\
                  /__\\
                 ( •_•)
                 /|\\ ║
                /_|_\\║════>
                  |   ║
                 / \\║
                /   \\|
               /     \\
              ╱       ╲
              "
              ;;
            "Guardián Arbóreo")
              echo -e "${GREEN}Tú (Guardián Arbóreo):${NC}"
              BarraVida $player_ps 100
              echo "
                  /\╲^^/\╲
                  ( o  o )
                  /  ^   ╲
                 /|\___/ |╲
                /_|/    \|_╲
                 ||  |  |||
                 ||  |  |||    
                / |  |  || ╲
               /_/|__|__||\_\====>
                 ||     ||  
                / ╲╲   / ╲╲
              "
              ;;
          esac

          # Separador
          echo -e "\n${YELLOW}VS${NC}\n"

          # Mostrar personaje enemigo
          case $enemy_name in
            "Guerrero")
              echo -e "${RED}Enemigo (Guerrero):${NC}"
              BarraVida $enemy_ps 100
              echo "
                _|_
               /___╲
               |o o|
               |_^_|
              ╭┴───┴╮
              │╱ ║  │      /
              │  ║  │     /
             ╱   ║   ╲ _ /_
            ╱    ║    ╲_/
                 ║
                ╱|╲
               ╱ | ╲
              "
              ;;
            "Mago")
              echo -e "${RED}Enemigo (Mago):${NC}"
              BarraVida $enemy_ps 100
              echo "
                 .  
                / \  
               /___\  
               |o o|  
               |_-_|      
              /| |\      
             / | | \    
            @=======@  
             |/   \|  
             /     \  
            /       \  
           ╱         ╲ 
              "
              ;;
            "Esqueleto")
              echo -e "${RED}Enemigo (Esqueleto):${NC}"
              BarraVida $enemy_ps 100
              echo "
                .-.
               (o.o)     /
                |=|     /
               __|__  _/_
             _/  |  \_/
                 |
                / \  
               /   \ 
              /     ╲
             /       ╲
              "
              ;;
            "Arquero")
              echo -e "${RED}Enemigo (Arquero):${NC}"
              BarraVida $enemy_ps 100
              echo "
                
                   /\\
                  /__\\
                 ( •_•)
                 /|\\ ║
                /_|_\\║════>
                  |   ║
                 / \\║
                /   \\|
               /     \\
              ╱       ╲
              "
              ;;
            "Guardián Arbóreo")
              echo -e "${RED}Enemigo (Guardián Arbóreo):${NC}"
              BarraVida $enemy_ps 100
              echo "
                  /\╲^^/\╲
                  ( o  o )
                  /  ^   ╲
                 /|\___/ |╲
                /_|/    \|_╲
                 ||  |  |||
                 ||  |  |||    
                / |  |  || ╲
               /_/|__|__||\_\====>
                 ||     ||  
                / ╲╲   / ╲╲
              "
              ;;
          esac

          # Mostrar efectos activos
          if [[ $player_burn -gt 0 || $player_poison -gt 0 || $player_stun -gt 0 || 
                $player_immune -gt 0 || $player_rage -gt 0 ]]; then
            echo -e "\n${YELLOW}Tus efectos:${NC}"
            [[ $player_burn -gt 0 ]] && echo "Quemadura ($player_burn turnos)"
            [[ $player_poison -gt 0 ]] && echo "Veneno ($player_poison turnos)"
            [[ $player_stun -gt 0 ]] && echo "Aturdido"
            [[ $player_immune -gt 0 ]] && echo "Inmune ($player_immune turnos)"
            [[ $player_rage -gt 0 ]] && echo "Ira (+10 daño, $player_rage turnos)"
          fi

          if [[ $enemy_burn -gt 0 || $enemy_poison -gt 0 || $enemy_stun -gt 0 || 
                $enemy_immune -gt 0 || $enemy_rage -gt 0 ]]; then
            echo -e "\n${YELLOW}Efectos enemigos:${NC}"
            [[ $enemy_burn -gt 0 ]] && echo "Quemadura ($enemy_burn turnos)"
            [[ $enemy_poison -gt 0 ]] && echo "Veneno ($enemy_poison turnos)"
            [[ $enemy_stun -gt 0 ]] && echo "Aturdido"
            [[ $enemy_immune -gt 0 ]] && echo "Inmune ($enemy_immune turnos)"
            [[ $enemy_rage -gt 0 ]] && echo "Ira (+10 daño, $enemy_rage turnos)"
          fi

          # Mostrar opciones de ataque (solo si no está aturdido)
          if [[ $player_stun -eq 0 ]]; then
            echo -e "\n${YELLOW}Elige tu acción:${NC}"
            if [[ $player_name == "Guerrero" ]]; then
              echo "1. Golpe Devastador (25 daño, 80% precisión)"
              echo "2. Embate Escudado (10 daño, 70% precisión, aturde 1 turno)"
              echo "3. Ira del Guerrero (habilidad especial, aumenta daño ataques por +10 por 3 turnos, 1 vez por combate)"
              echo "4. Curarse (recupera 10 PS)"
            elif [[ $player_name == "Mago" ]]; then
              echo "1. Llama Arcana (15 daño, 90% precisión + Quemadura de 5 de daño por 2 turnos)"
              echo "2. Rayo Concentrado (15 daño, 80% precisión)"
              echo "3. Esfera de Protección (habilidad especial, inmune por 2 turnos, recupera 10 PS por turno, 1 vez por combate)"
              echo "4. Curarse (recupera 10 PS)"
            elif [[ $player_name == "Esqueleto" ]]; then
              echo "1. Corte Crujiente (18 daño, 90% precisión)"
              echo "2. Polvo Infecto (18 daño + envenena, 75% precisión)"
              echo "3. Resurgir de los huesos (Se activa cuando pierde todos los PS, 1 vez por partida, revive con 30 PS, 5 de daño)"
              echo "4. Curarse (recupera 10 PS)"
            elif [[ $player_name == "Arquero" ]]; then
              echo "1. Flecha Precisa (20 daño, 75% precisión)"
              echo "2. Flecha Venenosa (10 daño + envenena 5 daño por 2 turnos, 90% precisión)"
              echo "3. Disparo Fantasma (25 daño, inmune por 1 turno, 1 vez por combate)"
              echo "4. Curarse (recupera 10 PS)"
            elif [[ $player_name == "Guardián Arbóreo" ]]; then
              echo "1. Martillazo de Raíz (18 daño, 80% precisión, 50% aturdir)"
              echo "2. Enredaderas Constrictoras (10 daño, 90% precisión)"
              echo "3. Corazón del Bosque (Regenera 10 PS, 5 daño, 1 vez por combate)"
              echo "4. Curarse (recupera 10 PS)"
            fi
          else
            echo -e "\n${YELLOW}¡Estás aturdido y no puedes actuar este turno!${NC}"
          fi
          
          # Solo permitir entrada si no está aturdido
          if [[ $player_stun -eq 0 ]]; then
            read -p "Opción: " action
          else
            action=0  # No acción cuando está aturdido
            player_stun=0  # El aturdimiento solo dura un turno
          fi
        
          # Turno del jugador (solo si no está aturdido)
          if [[ $player_stun -eq 0 ]]; then
            case $action in
              1) # Ataque básico
                if [[ $player_name == "Guerrero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 80 ]]; then  # 80% de probabilidad de éxito
                      damage=$((25 + ($player_rage > 0 ? 10 : 0)))
                      if [[ $enemy_immune -eq 0 ]]; then
                          enemy_ps=$((enemy_ps - damage))
                          echo -e "${GREEN}¡Golpe Devastador! Causas $damage de daño.${NC}"
                      else
                          echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                      fi
                  else
                      echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
              
                elif [[ $player_name == "Mago" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                    damage=$((15 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      enemy_burn=2
                      echo -e "${GREEN}¡Llama Arcana! Causas $damage de daño y quemadura.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Esqueleto" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                      damage=$((18 + ($player_rage > 0 ? 10 : 0)))  # Cambiado de 12 a 18
                      if [[ $enemy_immune -eq 0 ]]; then
                          enemy_ps=$((enemy_ps - damage))
                          echo -e "${GREEN}¡Corte Crujiente! Causas $damage de daño.${NC}"
                      else
                          echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                      fi
                  else
                      echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Arquero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 75 ]]; then
                    damage=$((20 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      echo -e "${GREEN}¡Flecha Precisa! Causas $damage de daño.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Guardián Arbóreo" ]]; then
                  if [[ $((RANDOM % 100)) -lt 80 ]]; then
                    damage=$((18 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      if [[ $((RANDOM % 2)) -eq 0 ]]; then
                        enemy_stun=1
                        echo -e "${GREEN}¡Martillazo de Raíz! Causas $damage de daño y aturdes al enemigo.${NC}"
                      else
                        echo -e "${GREEN}¡Martillazo de Raíz! Causas $damage de daño.${NC}"
                      fi
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                fi
                ;;

              2) # Ataque secundario
                if [[ $player_name == "Guerrero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 70 ]]; then
                    damage=$((10 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      enemy_stun=1
                      echo -e "${GREEN}¡Embate Escudado! Causas $damage de daño y aturdes al enemigo.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Mago" ]]; then
                  if [[ $((RANDOM % 100)) -lt 80 ]]; then
                    damage=$((15 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      echo -e "${GREEN}¡Rayo Concentrado! Causas $damage de daño.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Esqueleto" ]]; then
                  if [[ $((RANDOM % 100)) -lt 75 ]]; then
                      damage=$((18 + ($player_rage > 0 ? 10 : 0)))  # Cambiado de 8 a 18
                      if [[ $enemy_immune -eq 0 ]]; then
                          enemy_ps=$((enemy_ps - damage))
                          enemy_poison=3
                          echo -e "${GREEN}¡Polvo Infecto! Causas $damage de daño y envenenas al enemigo.${NC}"
                      else
                          echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                      fi
                  else
                      echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Arquero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                    damage=$((10 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      enemy_poison=2
                      echo -e "${GREEN}¡Flecha Venenosa! Causas $damage de daño y envenenas al enemigo.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                elif [[ $player_name == "Guardián Arbóreo" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                    damage=$((10 + ($player_rage > 0 ? 10 : 0)))
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - damage))
                      echo -e "${GREEN}¡Enredaderas Constrictoras! Causas $damage de daño.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                  else
                    echo -e "${RED}¡Fallaste el ataque!${NC}"
                  fi
                fi
                ;;

              3) # Habilidad especial
                if [[ $player_name == "Guerrero" ]]; then
                  if [[ $player_special_used -eq 0 ]]; then
                    player_rage=3
                    player_special_used=1
                    echo -e "${RED}¡Ira del Guerrero! Tus ataques harán +10 de daño por 3 turnos.${NC}"
                  else
                    echo -e "${YELLOW}Ya has usado tu habilidad especial en este combate.${NC}"
                  fi
                elif [[ $player_name == "Mago" ]]; then
                  if [[ $player_special_used -eq 0 ]]; then
                    player_immune=2
                    player_special_used=1
                    echo -e "${BLUE}¡Esfera de Protección! Eres inmune por 2 turnos y te regeneras.${NC}"
                  else
                    echo -e "${YELLOW}Ya has usado tu habilidad especial en este combate.${NC}"
                  fi
                elif [[ $player_name == "Esqueleto" ]]; then
                  echo -e "${CYAN}Resurgir de los huesos se activará automáticamente si mueres.${NC}"
                elif [[ $player_name == "Arquero" ]]; then
                  if [[ $player_special_used -eq 0 ]]; then
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - 25))
                      echo -e "${GREEN}¡Disparo Fantasma! Causas 25 de daño.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                    fi
                    player_immune=1
                    player_special_used=1
                    echo -e "${BLUE}¡Ahora eres inmune por 1 turno!${NC}"
                  else
                    echo -e "${YELLOW}Ya has usado tu habilidad especial en este combate.${NC}"
                  fi
                elif [[ $player_name == "Guardián Arbóreo" ]]; then
                  if [[ $player_special_used -eq 0 ]]; then
                    player_ps=$((player_ps + 10))
                    if [[ $player_ps -gt 100 ]]; then
                      player_ps=100
                    fi
                    if [[ $enemy_immune -eq 0 ]]; then
                      enemy_ps=$((enemy_ps - 5))
                      echo -e "${GREEN}¡Corazón del Bosque! Te regeneras 10 PS y causas 5 de daño al enemigo.${NC}"
                    else
                      echo -e "${BLUE}¡El enemigo es inmune y no recibe daño!${NC}"
                      echo -e "${GREEN}¡Corazón del Bosque! Te regeneras 10 PS.${NC}"
                    fi
                    player_special_used=1
                  else
                    echo -e "${YELLOW}Ya has usado tu habilidad especial en este combate.${NC}"
                  fi
                fi
                ;;

              4) # Curarse
                if [[ $player_heals_left -gt 0 && $player_ps -lt 50 ]]; then
                  heal_amount=10
                  player_ps=$((player_ps + heal_amount))
                  if [[ $player_ps -gt 100 ]]; then
                    player_ps=100
                  fi
                  player_heals_left=$((player_heals_left - 1))
                  echo -e "${RED}¡Te curas $heal_amount PS! (${player_heals_left} curaciones restantes)${NC}"
                fi
                ;;
            esac
          else
            echo -e "${YELLOW}¡Estás aturdido y no puedes actuar este turno!${NC}"
            player_stun=0  # El aturdimiento solo dura un turno
          fi

          # Verificar si el enemigo ha muerto
          if [[ $enemy_ps -le 0 ]]; then
            if [[ $enemy_name == "Esqueleto" && $enemy_special_used -eq 0 ]]; then
              enemy_ps=30
              enemy_special_used=1
              if [[ $player_immune -eq 0 ]]; then
                player_ps=$((player_ps - 5))
                echo -e "${CYAN}¡El Esqueleto enemigo revive con 30 PS y te causa 5 de daño!${NC}"
              else
                echo -e "${CYAN}¡El Esqueleto enemigo revive con 30 PS!${NC}"
                echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
              fi
            else
              break
            fi
          fi

          # Turno del enemigo (solo si no está aturdido)
          if [[ $enemy_stun -eq 0 ]]; then
              # IA mejorada - toma decisiones basadas en la situación
              if [[ $enemy_ps -lt 30 && $((RANDOM % 3)) -eq 0 && $enemy_special_used -eq 0 ]]; then
                  # 33% de probabilidad de usar habilidad especial si está herido
                  enemy_action=3
              elif [[ $enemy_ps -lt 60 && $((RANDOM % 4)) -eq 0 ]]; then
                  # 25% de probabilidad de curarse si tiene menos de 60 PS
                  enemy_action=4
              else
                  # Elección normal basada en probabilidades estratégicas
                  case $enemy_name in
                      "Guerrero")
                          # 60% ataque básico, 30% ataque secundario, 10% habilidad especial/curar
                          rand=$((RANDOM % 10))
                          if [[ $rand -lt 6 ]]; then
                              enemy_action=1
                          elif [[ $rand -lt 9 ]]; then
                              enemy_action=2
                          else
                              enemy_action=$((RANDOM % 2 + 3)) # 3 o 4
                          fi
                          ;;
                      "Mago")
                          # 50% ataque básico, 40% ataque secundario, 10% habilidad especial/curar
                          rand=$((RANDOM % 10))
                          if [[ $rand -lt 5 ]]; then
                              enemy_action=1
                          elif [[ $rand -lt 9 ]]; then
                              enemy_action=2
                          else
                              enemy_action=$((RANDOM % 2 + 3))
                          fi
                          ;;
                      "Esqueleto")
                          # 40% ataque básico, 50% ataque secundario, 10% curar
                          rand=$((RANDOM % 10))
                          if [[ $rand -lt 4 ]]; then
                              enemy_action=1
                          elif [[ $rand -lt 9 ]]; then
                              enemy_action=2
                          else
                              enemy_action=4
                          fi
                          ;;
                      "Arquero")
                          # 70% ataque básico, 20% ataque secundario, 10% habilidad especial/curar
                          rand=$((RANDOM % 10))
                          if [[ $rand -lt 7 ]]; then
                              enemy_action=1
                          elif [[ $rand -lt 9 ]]; then
                              enemy_action=2
                          else
                              enemy_action=$((RANDOM % 2 + 3))
                          fi
                          ;;
                      "Guardián Arbóreo")
                          # 30% ataque básico, 60% ataque secundario, 10% habilidad especial/curar
                          rand=$((RANDOM % 10))
                          if [[ $rand -lt 3 ]]; then
                              enemy_action=1
                          elif [[ $rand -lt 9 ]]; then
                              enemy_action=2
                          else
                              enemy_action=$((RANDOM % 2 + 3))
                          fi
                          ;;
                  esac
              fi

              # Si la habilidad especial ya fue usada, cambia curar o ataque normal
              if [[ $enemy_action -eq 3 && $enemy_special_used -eq 1 ]]; then
                  enemy_action=$((RANDOM % 2 + 1)) # 1 o 2
              fi
              
              # Si elige curar pero tiene PS altos, cambia a ataque
              if [[ $enemy_action -eq 4 && $enemy_ps -gt 80 ]]; then
                  enemy_action=$((RANDOM % 2 + 1)) # 1 o 2
              fi
            
            case $enemy_action in
              1) # Ataque básico
                if [[ $enemy_name == "Guerrero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 80 ]]; then  # 80% de probabilidad de éxito
                      damage=$((25 + ($enemy_rage > 0 ? 10 : 0)))
                      if [[ $player_immune -eq 0 ]]; then
                          player_ps=$((player_ps - damage))
                          echo -e "${RED}¡Golpe Devastador enemigo! Recibes $damage de daño.${NC}"
                      else
                          echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                      fi
                  else
                      echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
              
                elif [[ $enemy_name == "Mago" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                    damage=$((15 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      player_burn=2
                      echo -e "${RED}¡Llama Arcana enemiga! Recibes $damage de daño y quemadura.${NC}"
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Esqueleto" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                      damage=$((18 + ($enemy_rage > 0 ? 10 : 0)))  # Cambiado de 12 a 18
                      if [[ $player_immune -eq 0 ]]; then
                          player_ps=$((player_ps - damage))
                          echo -e "${RED}¡Corte Crujiente enemigo! Recibes $damage de daño.${NC}"
                      else
                          echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                      fi
                  else
                      echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Arquero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 75 ]]; then
                    damage=$((20 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      echo -e "${RED}¡Flecha Precisa enemiga! Recibes $damage de daño.${NC}"
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Guardián Arbóreo" ]]; then
                  if [[ $((RANDOM % 100)) -lt 80 ]]; then
                    damage=$((18 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      if [[ $((RANDOM % 2)) -eq 0 ]]; then
                        player_stun=1
                        echo -e "${RED}¡Martillazo de Raíz enemigo! Recibes $damage de daño y quedas aturdido.${NC}"
                      else
                        echo -e "${RED}¡Martillazo de Raíz enemigo! Recibes $damage de daño.${NC}"
                      fi
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                fi
                ;;

              2) # Ataque secundario
                if [[ $enemy_name == "Guerrero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 70 ]]; then
                    damage=$((10 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      player_stun=1
                      echo -e "${RED}¡Embate Escudado enemigo! Recibes $damage de daño y quedas aturdido.${NC}"
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Mago" ]]; then
                  if [[ $((RANDOM % 100)) -lt 80 ]]; then
                    damage=$((15 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      echo -e "${RED}¡Rayo Concentrado enemigo! Recibes $damage de daño.${NC}"
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Esqueleto" ]]; then
                  if [[ $((RANDOM % 100)) -lt 75 ]]; then
                      damage=$((18 + ($enemy_rage > 0 ? 10 : 0)))  # Cambiado de 8 a 18
                      if [[ $player_immune -eq 0 ]]; then
                          player_ps=$((player_ps - damage))
                          player_poison=3
                          echo -e "${RED}¡Polvo Infecto enemigo! Recibes $damage de daño y quedas envenenado.${NC}"
                      else
                          echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                      fi
                  else
                      echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Arquero" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                    damage=$((10 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      player_poison=2
                      echo -e "${RED}¡Flecha Venenosa enemiga! Recibes $damage de daño y quedas envenenado.${NC}"
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                elif [[ $enemy_name == "Guardián Arbóreo" ]]; then
                  if [[ $((RANDOM % 100)) -lt 90 ]]; then
                    damage=$((10 + ($enemy_rage > 0 ? 10 : 0)))
                    if [[ $player_immune -eq 0 ]]; then
                      player_ps=$((player_ps - damage))
                      echo -e "${RED}¡Enredaderas Constrictoras enemigas! Recibes $damage de daño.${NC}"
                    else
                      echo -e "${BLUE}¡Eres inmune y no recibes daño!${NC}"
                    fi
                  else
                    echo -e "${GREEN}¡El enemigo falló su ataque!${NC}"
                  fi
                fi
                ;;

              3) # Habilidad especial
                if [[ $enemy_name == "Guerrero" ]]; then
                  if [[ $enemy_special_used -eq 0 ]]; then
                    enemy_rage=3
                    enemy_special_used=1
                    echo -e "${RED}¡El enemigo entra en Ira del Guerrero! Sus ataques harán +10 de daño por 3 turnos.${NC}"
                  fi
                elif [[ $enemy_name == "Mago" ]]; then
                  if [[ $enemy_special_used -eq 0 ]]; then
                    enemy_immune=2
                    enemy_special_used=1
                    echo -e "${BLUE}¡El enemigo activa Esfera de Protección! Es inmune por 2 turnos y se regenera.${NC}"
                  fi
                elif [[ $enemy_name == "Arquero" ]]; then
                  if [[ $enemy_special_used -eq 0 ]]; then
                    player_ps=$((player_ps - 25))
                    enemy_evade=1
                    enemy_special_used=1
                    echo -e "${RED}¡Disparo Fantasma enemigo! Recibes 25 de daño y el enemigo evadirá tu próximo ataque.${NC}"
                  fi
                elif [[ $enemy_name == "Guardián Arbóreo" ]]; then
                  if [[ $enemy_special_used -eq 0 ]]; then
                    enemy_ps=$((enemy_ps + 10))
                    player_ps=$((player_ps - 5))
                    enemy_special_used=1
                    echo -e "${YELLOW}¡El enemigo activa Corazón del Bosque! Se regenera 10 PS y te causa 5 de daño.${NC}"
                  fi
                fi
                ;;

              4) # Curarse
                if [[ $enemy_heals_left -gt 0 && $enemy_ps -lt 50 ]]; then
                    heal_amount=10
                    enemy_ps=$((enemy_ps + heal_amount))
                    if [[ $enemy_ps -gt 100 ]]; then
                        enemy_ps=100
                    fi
                    enemy_heals_left=$((enemy_heals_left - 1))
                    echo -e "${RED}¡El enemigo se cura $heal_amount PS! (${enemy_heals_left} curaciones restantes)${NC}"
                fi

            esac
          else
            echo -e "${GREEN}¡El enemigo está aturdido y no puede atacar!${NC}"
            enemy_stun=0
          fi

          # Verificar si el jugador ha muerto
          if [[ $player_ps -le 0 ]]; then
            if [[ $player_name == "Esqueleto" && $player_special_used -eq 0 ]]; then
              player_ps=30
              player_special_used=1
              enemy_ps=$((enemy_ps - 5))
              echo -e "${CYAN}¡Resurgiste con 30 PS y causaste 5 de daño al enemigo!${NC}"
            else
              break
            fi
          fi

          # Aplicar efectos de estado al jugador
          if [[ $player_burn -gt 0 ]]; then
            if [[ $player_immune -eq 0 ]]; then
              player_ps=$((player_ps - 5))
              echo -e "${RED}¡Quemadura! Pierdes 5 PS.${NC}"
            else
              echo -e "${BLUE}¡Estás protegido de la quemadura por inmunidad!${NC}"
            fi
            player_burn=$((player_burn - 1))
          fi

          if [[ $player_poison -gt 0 ]]; then
            if [[ $player_immune -eq 0 ]]; then
              player_ps=$((player_ps - 3))
              echo -e "${PURPLE}¡Veneno! Pierdes 3 PS.${NC}"
            else
              echo -e "${BLUE}¡Estás protegido del veneno por inmunidad!${NC}"
            fi
            player_poison=$((player_poison - 1))
          fi

          if [[ $player_immune -gt 0 ]]; then
            player_ps=$((player_ps + 10))
            if [[ $player_ps -gt 100 ]]; then
              player_ps=100
            fi
            player_immune=$((player_immune - 1))
            echo -e "${BLUE}¡Regeneración mágica! Recuperas 10 PS.${NC}"
          fi

          # Aplicar efectos de estado al enemigo
          if [[ $enemy_burn -gt 0 ]]; then
            if [[ $enemy_immune -eq 0 ]]; then
              enemy_ps=$((enemy_ps - 5))
              echo -e "${GREEN}¡El enemigo sufre quemadura! Pierde 5 PS.${NC}"
            else
              echo -e "${RED}¡El enemigo está protegido de la quemadura por inmunidad!${NC}"
            fi
            enemy_burn=$((enemy_burn - 1))
          fi

          if [[ $enemy_poison -gt 0 ]]; then
            if [[ $enemy_immune -eq 0 ]]; then
              enemy_ps=$((enemy_ps - 3))
              echo -e "${GREEN}¡El enemigo sufre veneno! Pierde 3 PS.${NC}"
            else
              echo -e "${RED}¡El enemigo está protegido del veneno por inmunidad!${NC}"
            fi
            enemy_poison=$((enemy_poison - 1))
          fi

          if [[ $enemy_immune -gt 0 ]]; then
            enemy_ps=$((enemy_ps + 10))
            if [[ $enemy_ps -gt 100 ]]; then
              enemy_ps=100
            fi
            enemy_immune=$((enemy_immune - 1))
            echo -e "${RED}¡El enemigo se regenera mágicamente! Recupera 10 PS.${NC}"
          fi

          # Reducir contadores de efectos adicionales
          if [[ $player_rage -gt 0 ]]; then
            player_rage=$((player_rage - 1))
          fi

          if [[ $enemy_rage -gt 0 ]]; then
            enemy_rage=$((enemy_rage - 1))
          fi

          # Limpiar evasión al final de cada turno
          player_evade=0
          enemy_evade=0

          # Esperar para continuar
          read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
        done

        # Resultado del combate
        if [[ $player_ps -le 0 && $enemy_ps -le 0 ]]; then
          echo -e "${YELLOW}*** EMPATE ***${NC}"
        elif [[ $player_ps -le 0 ]]; then
          echo -e "${RED}*** HAS PERDIDO ***${NC}"
        else
          echo -e "${GREEN}*** HAS GANADO ***${NC}"
        fi

        read -n 1 -s -r -p "Presiona cualquier tecla para volver al menú..."
        ;;
      2)
        clear
        echo -e "${YELLOW}=== PERSONAJES DISPONIBLES ===${NC}"
        
        # Guerrero
        echo -e "\n${RED}1. Guerrero:${NC} Fuerte y resistente, ideal para combate cuerpo a cuerpo."
        echo "
            _|_
           /___╲
           |o o|
           |_^_|
          ╭┴───┴╮
          │╱ ║  │      /
          │  ║  │     /
         ╱   ║   ╲ _ /_
        ╱    ║    ╲_/
             ║
            ╱|╲
           ╱ | ╲
        "
        echo -e "${YELLOW}=== ESTADÍSTICAS Y ATAQUES ===${NC}"
        echo -e "${GREEN}PS: 100${NC}\n"

        echo -e "${BLUE}Golpe Devastador:${NC} El guerrero concentra toda su fuerza en un golpe descendente con su espada, capaz de atravesar escudos y romper defensas.${NC}"
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 25"
        echo -e "${BLUE}Precisión:${NC} 80%\n"
        
        echo -e "${BLUE}Embate Escudado:${NC} El guerrero embiste con su escudo, aturdiendo al enemigo un turno y abriendo una oportunidad para el próximo turno. 70% de probabilidad de éxito"
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 10"
        echo -e "${BLUE}Precisión: ${NC}70%"
        echo -e "${NC}Aturde al enemigo 1 turno${NC}\n"
        

        echo -e "${BLUE}HABILIDAD ESPECIAL${NC}"
        echo -e "${BLUE}Ira del Guerrero:${NC} El guerrero canaliza su furia interior, entrando en un estado de furor que potencia sus ataques y lo hace más resistente durante un breve tiempo."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${NC}Aumenta el daño de sus ataques en +10 durante 3 turnos${NC}"
        echo -e "${NC}Solo se puede usar una vez por combate${NC}\n"


        read -n 1 -s -r -p "Presiona cualquier tecla para ver el siguiente personaje..."
        clear

        # Mago
        echo -e "\n${BLUE}2. Mago:${NC} Conocedor de poderosos hechizos, especialista en ataques a distancia."
        echo "
             .  
            / \  
           /___\  
           |o o|  
           |_-_|      
          /| |\      
         / | | \    
        @=======@  
         |/   \|  
         /     \  
        /       \  
       ╱         ╲ 
        "
        echo -e "${YELLOW}=== ESTADÍSTICAS Y ATAQUES ===${NC}"
        echo -e "${GREEN}PS: 100${NC}\n"

        echo -e "${BLUE}Llama Arcana:${NC} El mago invoca una ráfaga de fuego mágico que arde con intensidad sobrenatural, quemando al enemigo incluso después del impacto."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 15"
        echo -e "${BLUE}Efecto adicional:${NC} Quemadura — el enemigo recibe 5 de daño extra durante los próximos 2 turnos."
        echo -e "${BLUE}Precisión:${NC} 90%\n"

        echo -e "${BLUE}Rayo Concentrado:${NC} El mago canaliza energía pura en un rayo dirigido, capaz de perforar defensas mágicas y golpear con precisión quirúrgica."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 15"
        echo -e "${BLUE}Precisión:${NC} 80%\n"

        echo -e "${BLUE}HABILIDAD ESPECIAL${NC}"
        echo -e "${BLUE}Esfera de Protección:${NC} El mago invoca una barrera mágica envolvente que lo aísla del daño y le permite recuperar energía interiormente."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${NC}Durante 2 turnos, el mago es inmune a todo daño.${NC}"
        echo -e "${NC}Recupera 10 PS por turno.${NC}"
        echo -e "${NC}Solo se puede usar una vez por combate.${NC}\n"


        read -n 1 -s -r -p "Presiona cualquier tecla para ver el siguiente personaje..."
        clear

        # Esqueleto
        echo -e "\n${CYAN}3. Esqueleto:${NC} Guerrero no-muerto con habilidades macabras."
        echo "
            .-.
           (o.o)     /
            |=|     /
           __|__  _/_
         _/  |  \_/
             |
            / \  
           /   \ 
          /     ╲
         /       ╲
        "

        echo -e "${YELLOW}=== ESTADÍSTICAS Y ATAQUES ===${NC}"
        echo -e "${GREEN}PS: 100${NC}\n"

        echo -e "${BLUE}Corte Crujiente:${NC} El esqueleto balancea su espada oxidada con un chillido de huesos al moverse, causando un tajo rápido que puede desgarrar armaduras viejas."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 18"
        echo -e "${BLUE}Precisión:${NC} 90%\n"

        echo -e "${BLUE}Polvo Infecto:${NC} El esqueleto sacude su cuerpo en descomposición, liberando una nube de polvo maldito que penetra en heridas abiertas y debilita al enemigo."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 18"
        echo -e "${BLUE}Efecto adicional:${NC} Envenena al enemigo, causando 3 puntos de daño por turno durante 3 turnos."
        echo -e "${BLUE}Precisión:${NC} 75%\n"

        echo -e "${BLUE}HABILIDAD ESPECIAL${NC}"
        echo -e "${BLUE}Resurgir de los Huesos:${NC} Cuando parece derrotado, el esqueleto se recompone con energía oscura, volviendo a levantarse mientras sus huesos se encajan entre sí con un crujido antinatural."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${NC}Revive con 30 PS.${NC}"
        echo -e "${NC}Solo se activa una vez, automáticamente al morir.${NC}"
        echo -e "${BLUE}Efecto adicional:${NC} Al revivir, inflige 5 puntos de daño a todos los enemigos cercanos (explosión ósea).\n"


        read -n 1 -s -r -p "Presiona cualquier tecla para ver el siguiente personaje..."
        clear

        echo -e "\n${GREEN}4. Arquero:${NC} Silencioso y letal, su puntería no falla bajo presión."
        echo "
            
               /\\
              /__\\
             ( •_•)
             /|\\ ║
            /_|_\\║════>
              |   ║
             / \\║
            /   \\|
           /     \\
          ╱       ╲
    "
        echo -e "${YELLOW}=== ESTADÍSTICAS Y ATAQUES ===${NC}"
        echo -e "${GREEN}PS: 100${NC}\n"

        echo -e "${BLUE}Flecha Precisa:${NC} El arquero apunta con calma y dispara una flecha directamente a un punto vital, causando daño con gran precisión. "
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 20"
        echo -e "${BLUE}Precisión:${NC} 75%\n"

        echo -e "${BLUE}Flecha Venenosa:${NC} El arquero recubre la punta de su flecha con veneno y la dispara con precisión, debilitando lentamente al enemigo. "
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 10"
        echo -e "${BLUE}Efecto adicional:${NC} Envenena al enemigo, causando 5 puntos de daño por turno durante 2 turnos."
        echo -e "${BLUE}Precisión:${NC} 90%\n"

        echo -e "${BLUE}HABILIDAD ESPECIAL${NC}"
        echo -e "${BLUE}Disparo Fantasma:${NC} El arquero desaparece entre las sombras y reaparece en posición ventajosa, disparando una flecha invisible que atraviesa la defensa del enemigo."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 25"
        echo -e "${BLUE}Efecto adicional:${NC} El arquero no puede ser atacado el próximo turno (evasión total)."
        echo -e "${NC}Solo una vez por combate.${NC}"

        read -n 1 -s -r -p "Presiona cualquier tecla para ver el siguiente personaje..."
        clear



        echo -e "${YELLOW}5. Guardián Arbóreo:${NC} Espíritu ancestral de los bosques milenarios"
        echo "
              /\╲^^/\╲
              ( o  o )
              /  ^   ╲
             /|\___/ |╲
            /_|/    \|_╲
             ||  |  |||
             ||  |  |||    
            / |  |  || ╲
           /_/|__|__||\_\====>
             ||     ||  
            / ╲╲   / ╲╲
          
"
        echo -e "${YELLOW}=== ESTADÍSTICAS Y ATAQUES ===${NC}"
        echo -e "${GREEN}PS: 100${NC}\n"

        echo -e "${BLUE}Martillazo de Raíz:${NC} El Guardián Arbóreo levanta su enorme brazo hecho de troncos y lo deja caer con fuerza sobre el suelo, haciendo temblar la tierra y dañando a todos los enemigos cercanos. "
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 18"
        echo -e "${BLUE}Efecto adicional:${NC} 50% de probabilidad de aturdir en el siguiente punto."
        echo -e "${BLUE}Precisión:${NC} 80%\n"

        echo -e "${BLUE}Enredaderas Constrictoras:${NC} El guardián extiende sus brazos hacia el suelo, haciendo brotar enredaderas que se enrollan alrededor del enemigo causando daño. "
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${BLUE}Daño:${NC} 10"
        echo -e "${BLUE}Precisión:${NC} 90%\n"

        echo -e "${BLUE}HABILIDAD ESPECIAL${NC}"
        echo -e "${BLUE}Corazón del Bosque:${NC} El guardián canaliza la energía vital del bosque ancestral, cubriéndose de corteza reforzada mientras raíces lo regeneran lentamente.."
        echo -e "${BLUE}EFECTO EN JUEGO${NC}"
        echo -e "${NC}Regenera 10 PS por turno mientras esté activo."
        echo -e "${NC}Además, cualquier enemigo que lo ataque durante este tiempo recibe 5 puntos de daño por espinas."
        echo -e "${NC}Usable una vez por combate.\n"


        read -n 1 -s -r -p "Presiona cualquier tecla para volver al menú..."
        ;;

      3)
        clear
        echo -e "${CYAN}=== ACERCA DEL JUEGO ===${NC}"
        echo "Un juego de combate por turnos donde eliges personajes con habilidades únicas:"
        echo -e "${RED}• Guerrero:${NC} Ataques físicos potentes"
        echo -e "${BLUE}• Mago:${NC} Hechizos elementales"
        echo -e "${CYAN}• Esqueleto:${NC} Habilidades vampíricas"
        echo -e "${GREEN}• Arquero:${NC} Precisión y ataques a distancia"
        echo -e "${YELLOW}• Guardián Arbóreo:${NC} Espíritu ancestral de los bosques milenarios"
        echo "El combate continúa hasta que un jugador agota sus PS."
        read -n 1 -s -r -p "Presiona cualquier tecla para volver al menú..."
        ;;

      4)
        echo -e "${RED}Saliendo del juego...${NC}"
        exit 0
        ;;
      *)
        echo -e "${RED}Opción no válida. Inténtalo de nuevo.${NC}"
        sleep 1
        ;;
    esac
  done
}
Menu  