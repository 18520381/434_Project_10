import matplotlib.pyplot as plt
from keras import backend as K

def feature_map_show(x, title):
    num_out_channels = x.shape[2]
    num_diagram_col = 4
    if num_out_channels >= 16:
        num_diagram_col = 8
    num_diagram_row = np.ceil(num_out_channels / num_diagram_col)

    num_diagram_col = int(num_diagram_col)
    num_diagram_row = int(num_diagram_row)

    fig, axs = plt.subplots(
        nrows=num_diagram_row,
        ncols=num_diagram_col,
        figsize=(7 * num_diagram_col, 5 * num_diagram_row)
    )

    for i in range(num_out_channels):
        row = i // num_diagram_col
        col = i  % num_diagram_col

        axs[row][col].imshow(x[:, :, i], cmap='gray')
        axs[row][col].axis('off')

    fig.suptitle(title, fontsize=30)
    fig.savefig('{:s}.png'.format(title))