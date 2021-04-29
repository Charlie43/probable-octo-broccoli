def solution(boxes: list):
    if not boxes or len(boxes) == 0:
        return 0

    max_dist = 0
    for i, v in enumerate(boxes):
        dist = get_distance(i, boxes)
        if dist > max_dist:
            max_dist = dist
    return max_dist


def get_distance(starting_idx, boxes):
    fdist = 0
    bdist = 0

    if starting_idx < len(boxes) - 1:
        # + 1 due to inclusive slice
        for i, x in enumerate(boxes[starting_idx + 1:]):
            if x - boxes[starting_idx + i] > 0:
                fdist = i
                break
        # If we get to the end without stopping, use i + 1 (to include the final digit)
        else:
            fdist = i + 1

    if starting_idx > 0:
        for i, x in enumerate(boxes[:starting_idx][::-1], 0):
            if x - boxes[starting_idx - i] > 0:
                bdist = i
                break
        # If we get to the end without stopping, use i + 1 (to include the final digit)
        else:
            bdist = i + 1

    # + 1 to include starting point
    return (fdist + bdist) + 1
