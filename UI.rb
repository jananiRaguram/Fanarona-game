class UI
  # UI class constants, pretty much strings that don't change
  # FANARONA game header strings
  Square = "\u{1f533}"
  Space = '  '
  H1 = "#{Square * 4}#{Space * 2}#{Square * 2}#{Space * 2}#{Square}#{Space * 2}#{Square}#{Space}#{Space}#{Square * 2}#{Space}#{Space}#{Square * 3}#{Space * 2}#{Space}#{Square * 2}#{Space * 2}#{Square}#{Space * 2}#{Square}#{Space}#{Space}#{Square * 2}#{Space}"
  H2 = "#{Square}#{Space * 4}#{Square}#{Space * 2}#{Square}#{Space}#{Square * 2}#{Space}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square * 2}#{Space}#{Square}#{Space}#{Square}#{Space * 2}#{Square}"
  H3 = "#{Square * 3}#{Space * 2}#{Square * 4}#{Space}#{Square}#{Space}#{Square * 2}#{Space}#{Square * 4}#{Space}#{Square * 3}#{Space * 2}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space}#{Square * 2}#{Space}#{Square * 4}"
  H4 = "#{Square}#{Space * 4}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space}#{Square * 2}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}"
  H5 = "#{Square}#{Space * 4}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Space}#{Square * 2}#{Space}#{Space}#{Square}#{Space * 2}#{Square}#{Space}#{Square}#{Space * 2}#{Square}"
  #  instructions section header strings

  def view_instructions # return game isntructions as a string, instructions are from boardSpace.net
    # create variables that store unicode character codes for the instructions section headings and bullets

    m_cap = 'M'
    o = "\u{1D428}"
    v = "\u{1D42F}"
    i = "\u{1D422}"
    n = "\u{1D427}"
    g = "\u{1D420}"
    c_cap = "\u{1D402}"
    a = "\u{1D41A}"
    p = "\u{1D429}"
    t = "\u{1D42D}"
    u = "\u{1D42E}"
    r = "\u{1D42B}"
    a_cap = 'A'
    t_cap = 'T'
    bullet_big = "\u25B6"
    bullet_small = "\u25B8"

    # make a multiline string for the Fanarona game instructions
    <<~INSTRUCTIONS

      Fanarona Instructions:

        #{bullet_big}#{m_cap}#{o}#{v}#{i}#{n}#{g}:#{' '}
            White moves first. Pieces are moved by sliding one Space along one of the lines. Note that some points lie on diagonal lines, while other have#{' '}
            only horizontal and vertical directions.

        #{bullet_big}#{c_cap}#{a}#{p}#{t}#{u}#{r}#{i}#{n}#{g}:
            you can capture a line of your opponent's pieces by approach by moving toward them into the adjacent Space, or by withdrawl by starting in the#{' '}
            adjacent Space and moving directly away from your opponent's piece. In some positions, you could capture either way,#{' '}
            and you must choose one or the other.

        #{bullet_big}#{a_cap} #{t_cap}#{u}#{r}#{n}:
            consists of either a single, non-capturing move, or a sequence of capturing moves. If any cpaturing moves are possible anywhere on the board,#{' '}
            then a cpaturing move must be made. If multiple captures are possible you can choose which to do. Subsequent captures ont eh sam eturn are#{' '}
            optional. Second and subsequent captures in the same turn are subject to some restrictions:
                #{bullet_small} you must keep moving the same piece
                #{bullet_small} you cannot return to any Space twice
                #{bullet_small} you can't move in the same direction twice in a row

    INSTRUCTIONS
  end

  def get_player_input # return player input as a string
    gets.chomp
  end

  def clear_screen
    print "\e[1;1H\e[2J"
  end

  def close_instructions(_type = 0) # if type = 1 delete terminal scroll back
    print "\e[1;1H\e[2J" # move everything off to the top of the screen (can scroll up and see it) Modified from GeeksforGeeks code
  end

  def display_instructions # display instruction and wait for the user to type 'q' or 'Q' to close the instructions
    instructions = view_instructions
    puts "#{instructions}"

    close = 'n'
    while close != 'q'
      print 'type q to close instructions: '
      close = get_player_input
      puts "You can only close the instructions by typing \'q\', please try again." if close != 'q'
      close = close.downcase # make it lower case
    end
    close_instructions
  end

  def print_fanarona_header
    puts "#{H1}"
    puts "#{H2}"
    puts "#{H3}"
    puts "#{H4}"
    puts "#{H5}"
  end
end
