import os
import time
import random
import keyboard

# Game settings
WIDTH = 70
HEIGHT = 20
GROUND_HEIGHT = HEIGHT - 1
PLAYER_X = 5

# Player
player = {
    'y': GROUND_HEIGHT,
    'vy': 0
}

# Game state
obstacles = []
score = 0
game_speed = 0.1

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def draw_game():
    screen = [[' ' for _ in range(WIDTH)] for _ in range(HEIGHT)]
    
    # Draw player
    screen[player['y']][PLAYER_X] = '&'
    
    # Draw obstacles
    for obs in obstacles:
        screen[GROUND_HEIGHT][obs] = '^'
    
    # Draw ground
    for i in range(WIDTH):
        screen[GROUND_HEIGHT][i] = '_'
    
    # Print screen
    clear_screen()
    for row in screen:
        print(''.join(row))
    print(f"Score: {score}")

def update_player():
    global player
    
    # Apply gravity
    player['y'] += player['vy']
    if player['y'] < GROUND_HEIGHT:
        player['vy'] += 1
    else:
        player['y'] = GROUND_HEIGHT
        player['vy'] = 0

def update_obstacles():
    global obstacles, score
    
    # Move obstacles
    obstacles = [obs - 1 for obs in obstacles]
    obstacles = [obs for obs in obstacles if obs >= 0]
    
    # Add new obstacle
    if len(obstacles) == 0 or obstacles[-1] < WIDTH - 20:
        if random.random() < 0.2:  # 20% chance to add a new obstacle
            obstacles.append(WIDTH - 1)
    
    # Update score
    score += 1

def check_collision():
    if PLAYER_X in obstacles and player['y'] == GROUND_HEIGHT:
        return True
    return False

def main():
    global game_speed, score
    
    while True:
        draw_game()
        update_player()
        update_obstacles()
        
        if keyboard.is_pressed('space') and player['y'] == GROUND_HEIGHT:
            player['vy'] = -2  # Jump
        
        if check_collision():
            print("Game Over!")
            break
        
        time.sleep(game_speed)
        
        # Increase game speed over time
        if score % 100 == 0 and game_speed > 0.05:
            game_speed -= 0.005

if __name__ == "__main__":
    print("Press 'Space' to jump. The game will start in 2 seconds.")
    time.sleep(2)
    main()
