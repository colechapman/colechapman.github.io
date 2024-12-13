import numpy as np

def fast_hals(V, rank, max_iter=100, epsilon=1e-6):
    m, n = V.shape
    W = np.abs(np.random.rand(m, rank))
    H = np.abs(np.random.rand(rank, n))
    errors = []

    for _ in range(max_iter):
        # Update H
        WtV = np.dot(W.T, V)
        WtW = np.dot(W.T, W) + epsilon * np.eye(rank)
        for j in range(rank):
            numerator = WtV[j, :] - np.dot(WtW[j, :], H) + WtW[j, j] * H[j, :]
            H[j, :] = np.maximum(0, H[j, :] + numerator / WtW[j, j])

        # Update W
        VHt = np.dot(V, H.T)
        HHt = np.dot(H, H.T) + epsilon * np.eye(rank)
        for j in range(rank):
            numerator = VHt[:, j] - np.dot(W, HHt[:, j]) + HHt[j, j] * W[:, j]
            W[:, j] = np.maximum(0, W[:, j] + numerator / HHt[j, j])

        # Compute Frobenius norm of the error
        error = np.linalg.norm(V - np.dot(W, H), 'fro')
        errors.append(error)

        # Early stopping
        if len(errors) > 1 and abs(errors[-1] - errors[-2]) < epsilon:
            break

    return W, H, errors
